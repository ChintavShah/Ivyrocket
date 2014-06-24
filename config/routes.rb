Rails.application.routes.draw do
  devise_for :users, skip: [:registrations, :passwords, :sessions]
  devise_scope :user do
    resource :registration,
      only: [:create, :edit, :update],
      path: 'users',
      path_names: { new: 'sign_up' },
      controller: 'users/registrations',
      as: :user_registration do
        get :cancel
      end
    resource :password,
      controller: 'users/passwords'
    get 'signin' => 'devise/sessions#new', :as => :new_user_session
    post 'signin' => 'devise/sessions#create', :as => :user_session
    delete 'signout' => 'devise/sessions#destroy', :as => :destroy_user_session
    get 'signup' => 'users/registrations#new', :as => :new_user_registration
    #get 'profile/:email/edit' => 'users/registrations#edit' :as => :
    #match '/profile/:email',    to: 'users/registrations#show',        via: 'get'
    
    #get '/signin' => 'devise/sessions#new'
    #match '/signout',    to: 'devise/sessions#destroy',        via: 'delete'
    #get '/signup' => 'users/registrations#new'
    #get '/signup_mentor' => 'users/registrations#new_mentor'
    
  end
  root 'static_pages#home'
  match '/pricing',    to: 'static_pages#pricing',        via: 'get'
  get 'mentors' => 'users#index', :as => :mentors
  get 'profile/:slug' => 'users#show', :as => :profile
  get 'profile/mentor_chat/:slug' => 'users#mentor_mailing', :as => :mentor_mailing_chat
  get 'profile/express_order/:slug' => 'users#express_order', :as => :express_order
  get 'order/' => 'orders#new', :as => :orders
  post 'order/' => 'orders#create'
  match '/about_us',  to: "static_pages#about_us",        via: 'get'
  match '/disclaimer',  to: "static_pages#disclaimer",        via: 'get'
  match '/our_team',  to: "static_pages#our_team",        via: 'get'
  match '/become_mentor',  to: "static_pages#become_mentor",        via: 'get'
  get 'user_index' => 'users#user_index', :as => :user_index
  get 'user_mentor/:id' => 'users#user_mentor', :as => :user_mentor


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
