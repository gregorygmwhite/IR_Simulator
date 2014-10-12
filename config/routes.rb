Simulator::Application.routes.draw do
  root :to => 'powerPresenter#welcome'
  match '/powers' => 'powerPresenter#power_index'
  match '/states/index' => 'powerPresenter#get_states'
  match '/methods/:power_type' => 'powerPresenter#method_pages'
end
