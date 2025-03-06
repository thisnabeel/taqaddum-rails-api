class CreateSponsorshipInterests < ActiveRecord::Migration[7.1]
  def change
    create_table :sponsorship_interests do |t|
      t.string :contact_name
      t.string :contact_email
      t.string :contact_phone
      t.string :org_name
      t.string :org_website
      t.text :org_details
      t.string :status

      t.timestamps
    end
  end
end
