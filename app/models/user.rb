class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :mentorships, dependent: :destroy
  has_many :mentored_skills, through: :mentorships, source: :skill

  has_many :menteeships, dependent: :destroy
  has_many :mentee_skills, through: :menteeships, source: :skill

  has_many :user_islamic_values
  has_many :islamic_values, through: :user_islamic_values

  has_many :user_availabilities

  has_many :meeting_offerings, through: :mentorships

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
end
