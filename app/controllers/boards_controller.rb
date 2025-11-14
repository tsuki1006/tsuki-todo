class BoardsController < ApplicationController
  before_action :authenticate_user!, only: [ :new ]

  def new
    @board = current_user.boards.build
  end

end