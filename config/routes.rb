Toq::Application.routes.draw do
  root :to => 'webpages#show'
  match '/login' => 'user_sessions#new', :as => :login, :via => :get
  match '/login' => 'user_sessions#create', :as => :login, :via => :post
  match '/logout' => 'user_sessions#destroy', :as => :logout
  match '/editor' => 'webpages#dashboard', :as => :dashboard

  resources :users, :path => '/editor/users'
  resources :contacts, :path => '/editor/contacts'

  resources :webpages, :path => '/editor/webpages' do    
    collection do
      post :send_email
      #get :dashboard
    end
    member do
      put :set_accessability
    end
    
    resources :subpages do
      collection do
        get :subpages_preview
      end

      member do
        put :set_accessability
      end
    end
  end

  resources :images, :only => :destroy do
    member do
      put :update_status
      put :update_caption
      put :order_images
    end
  end

  resources :widgets do
    member do
      put :update_status
      put :order_widgets
    end

    collection do
      get :update_content
    end
  end

  match '/:parent/:page_alias' => 'subpages#show',  :as => :subpage_show
  match '/:page_alias' => 'webpages#show',  :as => :webpage_show
end
