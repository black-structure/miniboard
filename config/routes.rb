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
  regex_num = /\d+/

  match 'boards/:board(/page:page)' => 'board#index', :constraints => { board: regex_board, page: regex_num }
  match 'boards/:board/:thrd' => 'board#get_thread', :constraints => { board: regex_board, thrd: regex_num }
  match 'boards/:board/:thrd/:post' => 'board#get_post', :constraints => { board: regex_board, thrd: regex_num, post: regex_num }
  
  match 'boards/:board/new' => 'board#new_thread', :constraints => { :board => regex_board }
  match 'boards/:board/:thrd/new' => 'board#new_post', :constraints => { :board => regex_board, :thrd => regex_num }

  match 'boards/:board/delete' => 'board#delete', :constraints => { :board => regex_board }
  match 'boards/:board/:thrd/delete' => 'board#delete', :constraints => { :board => regex_board, :thrd => regex_num }

end
