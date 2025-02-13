class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :mentorships, dependent: :destroy
  has_many :mentored_skills, through: :mentorships, source: :skill

  has_many :menteeships, dependent: :destroy
  has_many :mentee_skills, through: :menteeships, source: :skill

  has_many :user_islamic_values, dependent: :destroy
  has_many :islamic_values, through: :user_islamic_values

  has_many :user_availabilities, dependent: :destroy

  has_many :meeting_offerings, through: :mentorships
  
  has_many :slots, dependent: :destroy

  # Avatar
  def upload_avatar(params)
    # require 'aws-sdk'

    user = self
    avatar_original = params[:avatar_original]
    avatar_cropped = params[:avatar_cropped]

    # return avatar_cropped
    # user.update(avatar_original_url: upload_aws(user, "original", avatar_cropped))
    if avatar_original.present?
      user.update(avatar_source_url: upload_aws(user, "original", avatar_original))
    end
    user.update(avatar_cropped_url: upload_aws(user, "cropped", avatar_cropped))
    return user
  end

  def upload_aws(user, key, file)
    s3 = Aws::S3::Resource.new
    file_name = key + ".jpeg"
    obj = s3.bucket('taqaddum').object("users/#{user.id}/avatar/#{key}/#{file_name}")
    puts "Uploading file #{file_name}"
    obj.upload_file(file, acl:'public-read')
    return obj.public_url
  end

  def available_meetups_for_next_week
    availabilities = self.user_availabilities
                     .where("start_time >= ? AND start_time <= ?", 
                            Time.zone.now.beginning_of_day, 
                            Time.zone.now.end_of_day + 7.days)

    generate_potential_meetups(meeting_offerings, availabilities)
  end

  private

  def generate_potential_meetups(meeting_offerings, availabilities)
    availability_map = merge_adjacent_availabilities(availabilities)
    potential_meetups = []
    unmatched_offerings = []

    # ✅ Preload existing slots to minimize DB queries
    existing_slots = Slot.where(
      user_id: self.id, 
      meeting_offering_id: meeting_offerings.map(&:id)
    ).index_by { |s| [s.start_time, s.end_time, s.meeting_offering_id] }

    meeting_offerings.each do |offering|
      offering_matched = false

      availability_map.each do |day, avail_list|
        booking_date = nearest_occurrence_of(day) # Get the correct UTC date

        avail_list.each do |avail|
          duration = offering.duration.minutes

          # ✅ Force Rails to treat `start_time` and `end_time` as UTC
          slot_start = booking_date.in_time_zone("UTC").beginning_of_day + avail[:start_time].seconds_since_midnight
          slot_end = booking_date.in_time_zone("UTC").beginning_of_day + avail[:end_time].seconds_since_midnight

          while slot_start + duration <= slot_end
            # ✅ Check if a slot already exists
            slot_key = [slot_start, slot_start + duration, offering.id]
            existing_slot = existing_slots[slot_key]
            status = existing_slot ? existing_slot.status : "open"

            potential_meetups << {
              user_id: offering.mentorship.user_id,
              title: offering.title,
              day: day,
              booking_date: booking_date.iso8601,  # Store date in ISO 8601 (UTC)
              start_time: slot_start.utc.iso8601,  # Ensure UTC time
              end_time: (slot_start + duration).utc.iso8601,  # Ensure UTC time
              duration: offering.duration,
              status: status,  # ✅ Include status (locked, denied, potential)
              offering: MeetingOfferingSerializer.new(offering)
            }

            slot_start += duration
            offering_matched = true
          end
        end
      end

      unless offering_matched
        unmatched_offerings << {
          title: offering.title,
          required_duration: offering.duration,
          message: "No available slots long enough for this meeting offering.",
          offering: MeetingOfferingSerializer.new(offering)
        }
      end
    end

    # ✅ Ensure ordering remains consistent
    potential_meetups.sort_by! { |m| [m[:booking_date], m[:start_time]] }

    { potential_meetups: potential_meetups.take(50), unmatched_offerings: unmatched_offerings.take(10), mentor: self }
  end

  # ✅ Fix: Finds **next** occurrence of the given weekday **without skipping a week**
  def nearest_occurrence_of(day_name)
    today = Time.zone.today
    target_day = Date::DAYNAMES.index(day_name)

    delta = (target_day - today.wday) % 7
    today + delta.days
  end

  # ✅ Optimized: Merges adjacent availabilities to create larger available blocks
  def merge_adjacent_availabilities(availabilities)
    merged_map = {}

    availabilities.group_by(&:day).each do |day, slots|
      sorted_slots = slots.sort_by(&:start_time)

      merged = []
      current_start = sorted_slots.first.start_time
      current_end = sorted_slots.first.end_time

      sorted_slots.each_cons(2) do |a, b|
        if a.end_time == b.start_time
          current_end = b.end_time # Extend the merged block
        else
          merged << { start_time: current_start, end_time: current_end }
          current_start = b.start_time
          current_end = b.end_time
        end
      end

      merged << { start_time: current_start, end_time: current_end } # Final block
      merged_map[day] = merged
    end

    merged_map
  end
end
