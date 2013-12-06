class CreateJobPostings < ActiveRecord::Migration
  def change
    create_table :job_postings do |t|
      t.string :title
      t.string :employment_type
      t.string :location
      t.text :description
      t.string :compensation
      t.string :contact
      t.string :url

      t.timestamps
    end
  end
end
