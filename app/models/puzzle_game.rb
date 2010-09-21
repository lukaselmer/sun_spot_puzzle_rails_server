class PuzzleGame < ActiveRecord::Base
  named_scope :latest, :order => 'created_at DESC'
  named_scope :fastest, :limit => 3, :order => 'time_in_milliseconds ASC'
  named_scope :slowest, :limit => 3, :order => 'time_in_milliseconds DESC'
  named_scope :fewest_swaps, :limit => 3, :order => 'swap_times ASC'
  named_scope :most_swaps, :limit => 3, :order => 'swap_times DESC'

  def game_time
    #    seconds = (cycle_times * 250.0 / 1000.0).to_i
    #    minutes = ((seconds - (seconds % 60)) / 60).to_i
    #    seconds -= minutes * 60
    milliseconds = time_in_milliseconds.to_i
    seconds = ((milliseconds - (milliseconds % 1000)) / 1000).to_i
    milliseconds -= seconds * 1000
    minutes = ((seconds - (seconds % 60)) / 60).to_i
    seconds -= minutes * 60
    [minutes, seconds, milliseconds]
  end

  def game_time_in_words
    #    arr = game_time
    #    ret = ""
    #    ret += "#{arr[0]} Minute#{arr[0] > 1 ? 'n' : ''}, " if arr[0] > 0
    #    ret += "#{arr[1]} Sekunde#{arr[0] > 1 ? 'n' : ''}"
    #    ret
    if(time_in_milliseconds.to_i == 0)
      seconds = (cycle_times * 250.0 / 1000.0).to_i
      minutes = ((seconds - (seconds % 60)) / 60).to_i
      seconds -= minutes * 60
      return "#{"%02i" % minutes}:#{"%02i" % seconds}"
    end
    arr = game_time
    "#{"%02i" % arr[0]}:#{"%02i" % arr[1]}.#{"%0.3d" % arr[2]}"
  end
end
