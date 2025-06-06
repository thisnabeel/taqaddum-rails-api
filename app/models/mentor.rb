class Mentor < User

    def dashboard

        approved_mentorships = self.approved_mentorships
        pending_mentorships = self.pending_mentorships
        mentee_pool = self.mentee_pool
        bookings = self.bookings

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
    
    def mentee_pool
        Menteeship.where(status: "approved", skill_id: self.mentorships.where(status: "approved").map{|m| m.skill_id})
    end

    def pending_mentorships
        self.mentorships.where(status: "pending approval")
    end

    def approved_mentorships
        self.mentorships.where(status: "approved")
    end

    def bookings
        self.slots.where("start_time > ?", Time.current).order("start_time ASC").includes(:slot_bookings).where.not(slot_bookings: { id: nil })
    end

    def send_mentee_pool_email
        require "resend"
        Resend.api_key = ENV["RESEND_API_KEY"]

        mentees = mentee_pool.includes(:user, :skill)
        
        # Build HTML table for mentees
        mentee_rows = mentees.map do |menteeship|
            mentee = menteeship.user
            skill = menteeship.skill
            %Q(
                <tr style="border-bottom: 1px solid #e2e8f0; transition: background-color 0.2s;">
                    <td style="padding: 16px;">
                        <img src="#{mentee.avatar_cropped_url}" 
                             alt="#{mentee.first_name}'s avatar" 
                             style="width: 44px; height: 44px; border-radius: 50%; object-fit: cover; vertical-align: middle; border: 2px solid #e2e8f0;"
                        />
                    </td>
                    <td style="padding: 16px; color: #1e293b; font-weight: 500;">#{mentee.first_name} #{mentee.last_name}</td>
                    <td style="padding: 16px; color: #64748b;">#{menteeship.profession}</td>
                    <td style="padding: 16px; color: #64748b;">#{menteeship.company}</td>
                    <td style="padding: 16px;">
                        <span style="display: inline-block; padding: 4px 12px; background-color: #f1f5f9; color: #475569; border-radius: 20px; font-size: 13px;">
                            #{skill.title}
                        </span>
                    </td>
                </tr>
            )
        end.join

        html_content = %Q(
            <div style="font-family: Arial, sans-serif; max-width: 800px; margin: 0 auto; background-color: #f8fafc;">
                <!-- Hidden preheader text -->
                <div style="display: none; font-size: 1px; line-height: 1px; max-height: 0px; max-width: 0px; opacity: 0; overflow: hidden; mso-hide: all; font-family: sans-serif;">
                    Discover #{mentees.count} talented individuals waiting to learn from your expertise
                </div>

                <!-- Header Section -->
                <div style="background-color: #edf2f7; padding: 40px 20px; text-align: center; border-radius: 8px 8px 0 0;">
                    
                    <h1 style="color: #1e293b; margin: 0; font-size: 28px; font-weight: 600;">Your Latest Mentee Matches</h1>
                </div>

                <!-- Main Content -->
                <div style="background-color: white; padding: 40px; border-radius: 0 0 8px 8px; box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);">
                    <h2 style="color: #2c3e50; margin-bottom: 20px; font-size: 24px;">As-salamu alaykum #{self.first_name},</h2>
                    <p style="color: #64748b; margin-bottom: 30px; font-size: 14px; line-height: 1.6;">
                        We've hand-picked these talented individuals based on their strong alignment with your expertise.
                    </p>
                    
                    <div style="background-color: white; border-radius: 8px; overflow: hidden; margin: 20px 0;">
                        <table style="width: 100%; border-collapse: collapse; background-color: #fff;">
                            <thead>
                                <tr style="background-color: #f1f5f9;">
                                    <th style="padding: 16px; text-align: left;"></th>
                                    <th style="padding: 16px; text-align: left; color: #475569; font-size: 13px; text-transform: uppercase; letter-spacing: 0.5px;">Name</th>
                                    <th style="padding: 16px; text-align: left; color: #475569; font-size: 13px; text-transform: uppercase; letter-spacing: 0.5px;">Profession</th>
                                    <th style="padding: 16px; text-align: left; color: #475569; font-size: 13px; text-transform: uppercase; letter-spacing: 0.5px;">Company</th>
                                    <th style="padding: 16px; text-align: left; color: #475569; font-size: 13px; text-transform: uppercase; letter-spacing: 0.5px;">Skill</th>
                                </tr>
                            </thead>
                            <tbody>
                                #{mentee_rows}
                            </tbody>
                        </table>
                    </div>

                    <p style="color: #64748b; margin-top: 30px; font-size: 14px; line-height: 1.6;">
                        You can log in to your dashboard to connect with these mentees and schedule sessions.
                    </p>

                    <div style="text-align: center; margin: 40px 0;">
                        <a href="https://www.taqaddum.org" 
                           style="display: inline-block; 
                                  padding: 14px 32px; 
                                  background-color: #2563eb; 
                                  color: white; 
                                  text-decoration: none; 
                                  border-radius: 8px; 
                                  font-size: 14px; 
                                  font-weight: 500; 
                                  letter-spacing: 0.5px;
                                  box-shadow: 0 4px 6px -1px rgba(37, 99, 235, 0.2);">
                            Visit Dashboard
                        </a>
                    </div>
                    
                    <p style="color: #64748b; margin: 40px 0 20px; font-size: 14px; line-height: 1.6; text-align: center;">
                        May Allah bless you,<br>
                        <span style="color: #475569; font-weight: 500;">- The Taqaddum Team</span>
                    </p>

                    <div style="margin-top: 40px; padding-top: 20px; border-top: 1px solid #e2e8f0; color: #94a3b8; font-size: 12px; text-align: center;">
                        <p>This is an automated email from Taqaddum. Please do not reply to this email.</p>
                    </div>
                </div>
            </div>
        )

        payload = {
            "from": "Taqaddum Team <donotreply@office.taqaddum.org>",
            "to": [self.email],
            "html": html_content,
            "subject": "New Talent for you to Benefit! - #{Time.current.strftime('%d.%m.%y')}"
        }

        begin
            response = Resend::Emails.send(payload)
            return { success: true, message: "Mentee pool email sent successfully" }
        rescue => e
            return { success: false, message: e.message }
        end
    end

    def generate_fake_mentee(gender = ["male", "female"].sample)
        return nil if approved_mentorships.empty?

        avatar_url = gender == "male" ? 
            "https://avatar.iran.liara.run/public/boy" : 
            "https://avatar.iran.liara.run/public/girl"

        # Get available skill IDs
        mentorship = self.approved_mentorships.sample

        prompt = <<~PROMPT
          Generate a fake #{gender} Muslim Mentee profile who is interested in #{mentorship.skill.title}. 
          The mentee should be a young professional or student in one of these fields.
          
          Rules for generation:
          - First name should be a traditional Muslim #{gender} name
          - Last name should be a Muslim family name (dont just make it khan, mix it up)
          - Email should be professional and based on the generated name
          - Birthdate should make them between 20-35 years old
          - Profession and company should be relevant to #{mentorship.skill.title}
          - Profession should be something like student, internship, or junior position
          - LinkedIn URL should follow format: linkedin.com/in/firstname-lastname-customtext
          - Make sure the fields are different from the existing mentees: #{self.mentee_pool.map {|m| m.user.first_name + " " + m.user.last_name + " " + m.user.email + " " + m.company + " " + m.profession}.join(", ")}

          Return as JSON with exactly these fields:
          {
            "first_name": "string",
            "last_name": "string",
            "email": "string",
            "birthdate": "YYYY-MM-DD",
            "profession": "string",
            "company": "string",
            "avatar_cropped_url": "#{avatar_url}",
            "linkedin_url": "string",
            "type": "Mentee",
            "password": "test123" <- this is the password for the mentee not dynamic
          }
        PROMPT

        response = WizardService.ask(prompt)
        return nil if response.empty?

        mentee = Mentee.create!(response)

        menteeship = Menteeship.create!(
            user: mentee,
            skill: mentorship.skill,
            status: "approved",
            profession: response["profession"],
            company: response["company"]
        )
            
        return {
            mentee: mentee,
            menteeship: menteeship
        }
    end
end