class AllowNullOnMeetings < ActiveRecord::Migration[7.1]
  def change
    change_column_null :slots, :meeting_offering_id, true
  end
end
