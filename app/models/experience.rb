class Experience < ActiveRecord::Base
  belongs_to :user
  belongs_to :tag

  EXPERIENCE_LEVELS = {
    
  }

  def calculate_level
    self.taught
    self.taken
    self.gh_stat
  end

  def percent_to_next_level
  end
end
