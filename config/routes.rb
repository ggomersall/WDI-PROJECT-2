Rails.application.routes.draw do

  resources :addresses, :orders
  devise_for :users, controllers: {registrations: "registrations"}

  root "pages#home"

  get "/how_it_works" => "pages#how_it_works"

  get "/account" => "pages#account"

  post "/payment" => "orders#payment"

end
