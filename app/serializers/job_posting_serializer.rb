class JobPostingSerializer < ActiveModel::Serializer
  attributes :id, :title, :employment_type, :location, :description, :compensation, :contact, :url
end
