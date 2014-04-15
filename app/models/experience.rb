class Experience < ActiveRecord::Base
  include Math

  belongs_to :user
  belongs_to :tag

  before_save :update_level

  def self.order_by_level
    self.order('level DESC')
  end

  def self.by_category(category)
    self.joins(:tag).where("tags.category = ?", category)
  end

  def update_level
    self.level = calculate_level
  end

  def percent_to_next_level
    raw_xp = get_raw_xp.to_i
    (raw_xp % 5) * 20
  end

  private
  def calculate_level
    raw_xp = get_raw_xp.to_i
    raw_xp / 5
  end

  def get_raw_xp
    (taken * 2) + (taught * 4) + (sqrt(gh_stat) / 20)
  end
end
