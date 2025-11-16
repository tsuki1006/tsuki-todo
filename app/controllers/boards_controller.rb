class BoardsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create ]

  def new
    @board = current_user.boards.build
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def board_params
    params.require(:board).permit(:title, :content)
  end

end
