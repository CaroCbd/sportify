class Event < ApplicationRecord
  SPORT = ["padel","palet"]

  include PgSearch::Model

  belongs_to :playground
  belongs_to :organisator, class_name: "User"

  has_one :sport, through: :playground
  has_one :location, through: :playground
  has_many :participations
  has_many :players, through: :participations, source: :user

  attr_accessor :event_date, :start_time, :end_time

  before_save :reconstruct_dates

  pg_search_scope :global_search,
    against: [ :name ],
    associated_against: {
      sport: [ :name, :description ],
      location: [ :name]
  },
    using: {
      tsearch: { prefix: true }
    }

  def coordinates
    {
      lat: location.latitude,
      lng: location.longitude
    }
  end

  def address
    location.address
  end

  private

  def reconstruct_dates
    return unless @start_time.present? && @end_time.present? && @event_date.present?
    puts "\n\n\n\n "
    start_hours, start_minutes = @start_time.split(":")
    p @start_hours
    p @start_minutes
    p DateTime.parse(@event_date)

    self.start_at = DateTime.parse(@event_date).beginning_of_day + start_hours.to_i.hours + start_minutes.to_i.minutes

    end_hours, end_minutes = @end_time.split(":")
    self.end_at = DateTime.parse(@event_date).beginning_of_day + end_hours.to_i.hours + end_minutes.to_i.minutes

    p start_at
    p end_at
  end
end
