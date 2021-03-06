Rails.application.routes.draw do

  root to: "pages#home"


  devise_for :users,
             :path => '',
             :path_names => {:sign_in => 'login', :sign_out => 'logout', :edit => 'profile'},
             :controllers => { :omniauth_callbacks => "omniauth_callbacks",
                               :registrations => 'registrations'}

  resources :users, only: [:index, :show]
  resources :rooms do
    resource :user_rooms, only: [:create, :destroy]
    resources :messages
    get '/invitation' => 'rooms#invitation'
    resource :invitations, only: [:create, :destroy]
  end

  resources :directs

end
