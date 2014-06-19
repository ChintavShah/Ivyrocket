class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :text
    add_column :users, :bio, :text
    add_column :users, :school_name, :text
    add_column :users, :degree_year, :integer
    add_column :users, :hometown, :text
    add_column :users, :field_of_study, :text
    add_column :users, :major, :text
    add_column :users, :other_acceptances, :text
    add_column :users, :other_waitlists, :text
    add_column :users, :applied_early, :text
    add_column :users, :SAT_total, :integer
    add_column :users, :SAT_math, :integer
    add_column :users, :SAT_reading, :integer
    add_column :users, :SAT_writing, :integer
    add_column :users, :ACT_composite, :integer
    add_column :users, :class_rank, :text
    add_column :users, :main_high_school_awards, :text
    add_column :users, :main_extracurricular_activities, :text
    add_column :users, :job_experience, :text
    add_column :users, :volunteer_experience, :text
    add_column :users, :summer_activities, :text
    add_column :users, :my_strengths, :text
    add_column :users, :my_weaknesses, :text
    add_column :users, :why_i_think_i_was_accepted, :text
    add_column :users, :biggest_piece_of_advice_to_high_school_students, :text
    add_index :users, :name, unique: true
  end
end
