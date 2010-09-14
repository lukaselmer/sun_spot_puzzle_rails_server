class AddTimeInMillisecondsToPuzzleGame < ActiveRecord::Migration
  def self.up
    add_column :puzzle_games, :time_in_milliseconds, :decimal, :precision => 25, :default => 0
    PuzzleGame.all.each do |p|
      p.time_in_milliseconds = p.cycle_times * 250
      p.save
    end
  end

  def self.down
    remove_column :puzzle_games, :time_in_milliseconds
  end
end
