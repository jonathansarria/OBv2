class CreateCsClasses < ActiveRecord::Migration
  def change
    create_table :cs_classes do |t|
      t.text :html

      t.timestamps
    end
  end
end
