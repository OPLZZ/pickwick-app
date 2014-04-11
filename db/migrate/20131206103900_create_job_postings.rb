class CreateJobPostings < ActiveRecord::Migration
  def change

    create_table :job_postings do |t|
      t.integer :user_id, :limit => 5
      t.string  :checked, default: 'not_checked'
      t.string  :api_id
      t.string  :title
      t.string  :employment_type
      t.text    :description
      t.text    :location
      t.text    :compensation
      t.text    :contact
      t.text    :employer
      t.date    :start_date
      t.timestamps
    end

    add_index :job_postings, :user_id
    add_index :job_postings, :api_id

  end
end
