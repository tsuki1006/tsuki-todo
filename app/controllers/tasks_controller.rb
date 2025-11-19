class TasksController < ApplicationController
  before_action :authenticate_user!, only: [ :new ]
  before_action :set_board, only: [ :new ]

  def new
    @task = @board.tasks.build(user: current_user)
  end

  def set_board
    @board = Board.find(params[:board_id])
  end

end
