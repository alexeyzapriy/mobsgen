class Invitation < ApplicationRecord
  belongs_to :stoat
  belongs_to :event
end
