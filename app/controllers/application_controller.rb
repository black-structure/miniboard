class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def hmm
    @board
  end
end
