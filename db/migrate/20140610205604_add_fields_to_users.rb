class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :bio, :string
    add_column :users, :school_name, :string
    add_column :users, :degree_year, :integer
    add_column :users, :hometown, :string
    add_column :users, :field_of_study, :string
    add_column :users, :major, :string
    add_column :users, :other_acceptances, :string
    add_column :users, :other_waitlists, :string
    add_column :users, :applied_early, :string
    add_column :users, :SAT_total, :integer
    add_column :users, :SAT_math, :integer
    add_column :users, :SAT_reading, :integer
    add_column :users, :SAT_writing, :integer
    add_column :users, :ACT_composite, :integer
    add_column :users, :class_rank, :string
    add_column :users, :main_high_school_awards, :string
    add_column :users, :main_extracurricular_activities, :string
    add_column :users, :job_experience, :string
    add_column :users, :volunteer_experience, :string
    add_column :users, :summer_activities, :string
    add_column :users, :my_strengths, :string
    add_column :users, :my_weaknesses, :string
    add_column :users, :why_i_think_i_was_accepted, :string
    add_column :users, :biggest_piece_of_advice_to_high_school_students, :string
  end
end
