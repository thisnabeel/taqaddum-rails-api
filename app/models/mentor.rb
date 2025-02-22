class Mentor < User

    def dashboard

        approved_mentorships = self.mentorships.where(status: "approved")
        pending_mentorships = self.mentorships.where(status: "pending approval")
        mentee_pool = Menteeship.where(status: "approved", skill_id: approved_mentorships.map{|m| m.skill_id})

        bookings = self.slots.includes(:slot_bookings).where.not(slot_bookings: { id: nil })

        return {
            mentorships: {
                approved: approved_mentorships.map {|o| MentorshipSerializer.new(o)},
                pending: pending_mentorships.map {|o| MentorshipSerializer.new(o)}
            }, 
            mentees: {
                pool: mentee_pool.map {|o| MenteeshipSerializer.new(o, include_user: true)}
            },
            bookings: bookings.map {|o| SlotSerializer.new(o, include_user: false, include_mentees: true )}
        }
    end
end