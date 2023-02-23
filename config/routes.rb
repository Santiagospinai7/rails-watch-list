Rails.application.routes.draw do
  get 'bookmarks/new'
  get 'bookmarks/create'
  get 'bookmarks/destroy'
  get 'lists/list'
  get 'lists/new'
  get 'lists/create'
  get 'lists/show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # Lists controller
  get "lists", to: "lists#index"
  # Create new List
  get "lists/new", to: "lists#new"
  post "lists", to: "lists#create"
  # Read one
  get "lists/:id", to: "lists#show", as: "list"

  # Bookmarks controller
  # Add a new bookmark
  get "lists/:id/bookmarks/new", to: "bookmarks#new"
  post "lists/:id/bookmarks", to: "bookmarks#create"

  # Delete task
  delete "bookmarks/:id", to: "bookmarks#destroy"
end
