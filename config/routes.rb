Rails.application.routes.draw do
  resources :sponsorship_interests
  resources :skill_slot_ideas
  resources :letters
  resources :slot_bookings

  resources :meeting_offerings
  resources :user_islamic_values
  resources :islamic_values
  resources :proofs
  resources :menteeships
  resources :mentorships
  resources :skills

  get "/top_mentors" => "mentorships#top"
  get "/open_slots" => "user_availabilities#open_slots"


  devise_for :users, controllers: { registrations: "users/registrations", sessions: "users/sessions" }

  devise_scope :user do
    post "/upload_avatar" => "users/registrations#upload_avatar"
  end

  resources :slots do
    member do
      patch :confirm
      patch :block
    end
  end


  post "/slots/configure" => "slots#configure"

  put "/users/update" => "users#update"
  get "/list/mentors" => "users#mentors"
  get "/list/mentees" => "users#mentees"

  get "/mentors/:id/dashboard" => "mentors#dashboard"
  get "/mentees/:id/dashboard" => "mentees#dashboard"
  post '/create-checkout-session', to: 'checkout#create'

  get '/fundraiser/money_raised' => "checkout#money_raised"
  get '/success/:session_id' => "checkout#success"

  post "/skills/offerings_ai" => "skills#offerings_ai"
  resources :user_availabilities, only: [:index, :create, :update]
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
