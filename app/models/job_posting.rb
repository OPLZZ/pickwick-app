class JobPosting < ActiveRecord::Base

  belongs_to :user
  serialize :location
  serialize :compensation
  serialize :contact
  serialize :employer

  def set_valid
    self.update_column :checked, 'valid'
    self.update_column :updated_at, Time.now
  end

  def set_invalid
    self.update_column :checked, 'invalid'
    self.update_column :updated_at, Time.now
  end

  def description_text
    description.to_s.gsub("\n","<br />").html_safe
  end

  def location_text
    [ location["street"], location["city"], location["zip"] ].select{|l| !l.nil?}.join(", ")
  end

  def compensation_text
    [ compensation["value"], compensation["currency"], compensation["type"] ].select{|l| !l.nil?}.join(", ")
  end

  def contact_text
    [ contact["name"], contact["phone"], contact["email"] ].select{|l| !l.nil?}.join(", ")
  end

  def employer_text
    [ employer["name"], employer["type"] ].select{|l| !l.nil?}.join(", ")
  end
end
