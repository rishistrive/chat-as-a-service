class HomeController < ApplicationController
  def index
    session[:conversations] ||= []
    @users = User.all.where.not(id: current_user)
    @conversations = Conversation.includes(:recipient, :messages).where(id: session[:conversations])
  end
end
