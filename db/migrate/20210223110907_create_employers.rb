# frozen_string_literal: true

class CreateEmployers < ActiveRecord::Migration[6.1]
  def change
    create_table :employers do |t|
      t.string :name
      t.jsonb :mapping, null: false, default: '{}'

      t.timestamps
    end
    add_index :employers, :mapping, using: :gin
  end
end
