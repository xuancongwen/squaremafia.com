class RenameMeetingsToEvents < ActiveRecord::Migration
  def change
    rename_table :meetings, :events
  end
end
