Unstuckme::Application.routes.draw do

  api_version(module: "V1", path: { value: 'api/v1' }, defaults: { format: :json })  do
    resources :questions, only: [:create, :destroy, :show, :index]
  end
  # root to: 'application#index'

  require 'sidekiq/web'
  mount Sidekiq::Web, at: 'sidekiq'
  mount PgHero::Engine, at: 'pghero'
end
