class JobPosting < ActiveRecord::Base

  belongs_to :user
  serialize :location
  serialize :compensation
  serialize :contact
  serialize :employer

  after_save :save_to_api

  def save_to_api
    if self.checked == "valid"
      url = "#{ENV['PICKWICK_API_URL']}/vacancies.json?token=#{ENV['PICKWICK_API_TOKEN']}"
      http = Curl.post(url, {:payload => self.to_api.to_json})
      output = JSON.parse(http.body_str)
      self.api_id = output["results"].first["id"]
      update_column :api_id, self.api_id
    end
  end

  after_destroy :delete_from_api

  def delete_from_api
    if self.api_id
      url = "#{ENV['PICKWICK_API_URL']}/vacancies/#{self.api_id}.json?token=#{ENV['PICKWICK_API_TOKEN']}"
      easy = Curl::Easy.http_delete(url)
      easy.perform
    end
  end

  def set_valid
    self.update_column :checked, 'valid'
    self.update_column :updated_at, Time.now
    save_to_api
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

  def to_api

    out ={
      title:            self.title,
      employment_type:  self.employment_type,
      description:      self.description,
      location:         self.location,
      compensation:     { maximum: self.compensation["value"], minimum: self.compensation["value"], compensation_type: self.compensation["compensation_type"], currency: self.compensation["currency"] },
      contact:          self.contact,
      start_date:       self.start_date,
    }
    out[:id] = self.api_id if self.api_id
    if employer["type"] == "company"
      out[:employer] = {company: employer["name"]}
    else
      out[:employer] = {name: employer["name"]}
    end

    out
  end
end
