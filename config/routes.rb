Miniboard::Application.routes.draw do
  root :to => 'home#index'

  namespace :admin do
    resources :users
    
    resources :boards
    root :to => 'home#index'
  end
  
  devise_for :users, :controllers => { :sessions => 'admin/devise/sessions' },
                      :path => 'admin',
                      :path_names => {
                        :sign_in => 'login',
                        :sign_out => 'exit',
                        :sign_up => 'register',
                        :registration => 'r' }

  match 'boards/:board(/page:page)' => 'board#index', :constraints => { board: /[A-Za-z0-9]+/, page: /\d+/ }
  match 'boards/:board/:thrd' => 'board#thread', :constraints => { board: /[A-Za-z0-9]+/, thrd: /\d+/ }
  
  match 'boards/:board/new' => 'board#new_thread', :constraints => { :board => /[A-Za-z0-9]+/ }
  match 'boards/:board/:thrd/new' => 'board#new_post', :constraints => { :board => /[A-Za-z0-9]+/, :thrd => /\d+/ }

end
