class SponsorshipInterestSerializer < ActiveModel::Serializer
  attributes :id, :contact_name, :contact_email, :contact_phone, :org_name, :org_website, :org_details, :status, :created_at
end
