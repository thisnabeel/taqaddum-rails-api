class AddCompanyToMentorships < ActiveRecord::Migration[7.1]
  def change
    add_column :mentorships, :company, :string
    add_column :menteeships, :company, :string
    add_column :mentorships, :profession, :string
    add_column :menteeships, :profession, :string
    add_column :mentorships, :status, :string, default: "pending approval"
    add_column :menteeships, :status, :string, default: "pending approval"
  end
end
