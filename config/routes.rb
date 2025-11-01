Rottenpotatoes::Application.routes.draw do
  resources :movies do
  # Add new routes here
    get 'similar', on: :member
  end

  root to: redirect('/movies')
end
