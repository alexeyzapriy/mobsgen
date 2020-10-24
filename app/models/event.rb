class Event < ApplicationRecord
  has_many :invitations
  has_many :stoats, through: :invitations

  attr_accessor :number_of_mobs, :participants
end
