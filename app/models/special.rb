class Special < ActiveRecord::Base
  validates :name, presence: true
  validates :comedian_id, presence: true
  validates :runtime, presence: true
  belongs_to :comedian

  def self.average_runtime
    average(:runtime).to_i
  end

  def self.specials_for_comedians(comedians = [])
    where(comedian_id: comedians.map {|comedian| comedian.id})
  end

  def self.count_specials_by_comedian
    group(:comedian_id).count
  end
end
