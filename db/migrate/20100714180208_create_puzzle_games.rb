class CreatePuzzleGames < ActiveRecord::Migration
  def self.up
    create_table :puzzle_games do |t|
      t.integer :swap_times
      t.integer :cycle_times

      t.timestamps
    end
  end

  def self.down
    drop_table :puzzle_games
  end
end
