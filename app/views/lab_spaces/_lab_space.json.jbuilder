json.extract! lab_space, :id, :name, :description, :hours, :location, :contact_email, :contact_phone, :created_at, :updated_at
json.url lab_lab_space_url(lab_space.lab, lab_space, format: :json)
