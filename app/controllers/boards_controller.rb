class BoardsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy ]

  def index
    @boards = Board.all
  end

  def new
    @board = current_user.boards.build
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      redirect_to boards_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @board = Board.find(params[:id])
  end

  def update
    binding.pry
    @board = Board.find(params[:id])
    if @board.update(board_params)
      redirect_to boards_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    board = Board.find(params[:id])
    board.destroy!
    redirect_to boards_path
  end

  private
  def board_params
    params.require(:board).permit(:title, :content)
  end

end
