class SendAvailabilityReminderJob < ApplicationJob
  queue_as :default

  def perform
    users_without_availabilities = User.without_availabilities

    users_without_availabilities.each do |user|
      Resend::Emails.send(
        to: user.email,
        subject: "Set Your Availability for Mentor-Mentee Sessions",
        body: "As-salamu alaykum #{user.first_name},\n\nWe noticed you haven't set your availability yet. Please log in to your account and set your availability so we can recommend mentor-mentee sessions for you.\n\nJazakAllahu Khair,\nThe Taqaddum Team"
      )
    end
  end
end
