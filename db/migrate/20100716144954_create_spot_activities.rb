class CreateSpotActivities < ActiveRecord::Migration
  #address:string time_in_milliseconds:long celsius:float light:integer sw1:boolean sw2:boolean accel:float accelx:float accely:float accelz:float rel_accel:float rel_accelx:float rel_accely:float rel_accelz:float tiltx:float tilty:float tiltz:float
  def self.up
    create_table :spot_activities do |t|
      t.string :address
      #t.integer :time_in_milliseconds
      t.float :celsius
      t.integer :light
      t.boolean :sw1
      t.boolean :sw2
      t.float :accel
      t.float :accelx
      t.float :accely
      t.float :accelz
      t.float :rel_accel
      t.float :rel_accelx
      t.float :rel_accely
      t.float :rel_accelz
      t.float :tiltx
      t.float :tilty
      t.float :tiltz

      t.timestamps
    end
    execute "ALTER TABLE spot_activities ADD time_in_milliseconds LONG"
  end

  def self.down
    drop_table :spot_activities
  end
end
