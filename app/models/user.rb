class User < ActiveRecord::Base

  has_many :job_postings
end
