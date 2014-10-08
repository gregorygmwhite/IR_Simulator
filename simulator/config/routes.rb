Simulator::Application.routes.draw do
  root :to => 'powerPresenter#welcome'
  match '/powers' => 'powerPresenter#power_index'
end
