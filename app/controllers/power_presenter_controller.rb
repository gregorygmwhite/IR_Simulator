class PowerPresenterController < ApplicationController
  def welcome
    render :welcome
  end

  def power_index
    @states = StateSerializer.all_states
    render :index
  end

  def get_states
    render json: StateSerializer.all_states
  end
end
