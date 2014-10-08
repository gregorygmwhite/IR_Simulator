class PowerPresenterController < ApplicationController
  def welcome
    render :welcome
  end

  def power_index
    @states = StateSerializer.all_states
    render :index
  end
end
