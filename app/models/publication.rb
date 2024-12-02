class Publication < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :likes
  belongs_to :sport

  has_one_attached :photo

  after_create :broadcast_publication

  SPORTS = %w[Basketball Palet Padel Fléchettes Lancer\ de\ mouettes Tir\ à\ la\ mouette Tennis]

  private

  def broadcast_publication
    broadcast_prepend_to "publications",
    partial: "publications/publication",
    target:"publications",
    locals: { publication: self }
  end

end
