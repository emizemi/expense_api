Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :expenses do

    member do #requires an ID, acts on a member
     # get 'price'
     # post :filter
     # post 'filter'

     get 'show_price'
    end

    collection do #acts on a collection of objects
     # post :search

     get "find_largest_price"
     get "find_smallest_price"
     get "find_largest_quantity"
     get "find_smallest_quantity"
    end
  end

  resources :users do

  end
end
