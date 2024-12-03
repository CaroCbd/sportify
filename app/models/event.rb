class Event < ApplicationRecord
  belongs_to :playground
  belongs_to :organisator, class_name: "User"

  has_one :sport, through: :playground
  has_one :location, through: :playground
  has_many :participations
  has_many :players, through: :participations, source: :user

  SPORT = ["padel", "palet"]
  def coordinates
    {
      lat: location.latitude,
      lng: location.longitude
    }
  end

  def address
    location.address
  end

  include PgSearch::Model
  pg_search_scope :global_search,
  against: [ :name ],
  associated_against: {
    sport: [ :name, :description ],
    location: [ :name]
  },
  using: {
    tsearch: { prefix: true }
  }

end
