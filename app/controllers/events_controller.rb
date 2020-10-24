class EventsController < ApplicationController

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
    @participants = Stoat.all
  end

  def create
    number_of_mobs = params[:event][:number_of_mobs].to_i
    number_of_mobs = 1 if number_of_mobs < 1

    @participants = Stoat.where(email: params[:event][:participants])
    if number_of_mobs == 1
      e = Event.create
      e << @participants
      return [@participants.map(&:email)]
    end

    @mobs = []
    number_of_mobs.times { @mobs << [] }

    while @participants.present?
      new_guys = top_n(@participants, number_of_mobs)
      @mobs.each_with_index do |mob, index|
        mob << new_guys[index] if new_guys.length > index
      end
      @participants = Stoat.where(email: (params[:event][:participants] - @mobs.flatten))
    end
    @mobs.each do |mob|
      e = Event.create
      e.stoats << Stoat.where(email: mob)
    end
  end

  def top_n(participants, number_of_mobs)
    return [participants.first.email] if participants.size < 2

    result = participants.to_a.shuffle.map do |stoat|
      {
        stoat.email => participants.map do |p|
          { p.email => stoat.common_events(p).count } if p.email != stoat.email
        end.compact
      }
    end

    sorted = result.sort do |a, b|
      avalue = a.values.first.max{ |aa, ab| aa.values.first <=> ab.values.first }
      bvalue = b.values.first.max{ |ba, bb| ba.values.first <=> bb.values.first }
      bvalue.values.first <=> avalue.values.first
    end
    sorted[0..(number_of_mobs-1)].map { |p| p.keys.first }
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
