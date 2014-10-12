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

  def method_pages
    page_name = params[:power_type]
    render page_name.to_sym
  end
end
