class Mentee < User
    def dashboard
        # Get mentee's approved and pending mentorships
        approved_menteeships = self.menteeships.where(status: "approved")
        pending_menteeships = self.menteeships.where(status: "pending approval")
        
        # Find available mentors who are approved in the skills the mentee is interested in
        # This assumes mentees can indicate skills they're interested in
        mentor_pool = Mentorship.where(
            status: "approved", 
            skill_id: self.menteeships.map{|m| m.skill_id}
        )

        bookings = self.slot_bookings

        return {
            menteeships: {
                approved: approved_menteeships.map {|o| MenteeshipSerializer.new(o)},
                pending: pending_menteeships.map {|o| MenteeshipSerializer.new(o)}
            },
            mentors: {
                pool: mentor_pool.map {|o| MentorshipSerializer.new(o, include_user: true)},
                sessions: mentor_pool.map {|m| m.slots}.flatten.map {|s| SlotSerializer.new(s, include_user: true)}
            },
            bookings: bookings.map {|o| SlotBookingSerializer.new(o)}
        }
    end
end