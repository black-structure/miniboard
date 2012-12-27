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
  regex_board = /[A-Za-z0-9]+/

  match 'boards/:board(/page:page)' => 'board#index', :constraints => { board: regex_board, page: /\d+/ }
  match 'boards/:board/:thrd' => 'board#thread', :constraints => { board: regex_board, thrd: /\d+/ }
  
  match 'boards/:board/new' => 'board#new_thread', :constraints => { :board => regex_board }
  match 'boards/:board/:thrd/new' => 'board#new_post', :constraints => { :board => regex_board, :thrd => /\d+/ }

  match 'boards/:board/delete' => 'board#delete', :constraints => { :board => regex_board }
  match 'boards/:board/:thrd/delete' => 'board#delete', :constraints => { :board => regex_board, :thrd => /\d+/ }

end
