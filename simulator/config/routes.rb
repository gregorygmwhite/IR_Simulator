Simulator::Application.routes.draw do
  root :to => 'powerPresenter#welcome'
  match '/powers' => 'powerPresenter#power_index'
  match '/states/index' => 'powerPresenter#get_states'
end
