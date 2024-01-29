class Admin::HomesController < ApplicationController
  def top
    @schedules = Schedule.all
  end 
end
