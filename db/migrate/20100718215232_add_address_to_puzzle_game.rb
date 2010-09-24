class AddAddressToPuzzleGame < ActiveRecord::Migration
  def self.up
    add_column :puzzle_games, :address, :string
  end

  def self.down
    remove_column :puzzle_games, :address
  end
end
