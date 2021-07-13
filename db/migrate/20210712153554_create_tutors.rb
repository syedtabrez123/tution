class CreateTutors < ActiveRecord::Migration[5.2]
  def change
    create_table :tutors do |t|
    	t.string :name
    	t.references :course, foreign_key: true, dependent: :destroy, index: true
      t.timestamps
    end
  end
end
