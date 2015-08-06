Unstuckme::Application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  api_version(module: "V1", path: { value: 'api/v1' }, defaults: { format: :json })  do
    resources :questions, only: [:create, :destroy, :show, :index] do
    	collection do
    		post :vote
    		get :my_questions
    		get :my_answers
    	end
      post :unlock
    end
    resources :users, only: [] do
      collection do
        get :show
      end
    end
  end
  root to: 'dashboard#landing'

  require 'sidekiq/web'
  mount Sidekiq::Web, at: 'sidekiq'
  mount PgHero::Engine, at: 'pghero'
end
