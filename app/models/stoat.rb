class Stoat < ApplicationRecord
  has_many :invitations
  has_many :events, through: :invitations

  def common_events(stoat)
    events.all.select do |event|
      event.stoats.map(&:email).include?(stoat.email)
    end
  end
end
