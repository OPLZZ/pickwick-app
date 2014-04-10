class JobPosting < ActiveRecord::Base
  serialize :location
  serialize :compensation
  serialize :contact
  serialize :employer

end
