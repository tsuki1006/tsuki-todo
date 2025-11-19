class TasksController < ApplicationController
  before_action :authenticate_user!, only: [ :new ]

  def new
    @task = build_task
  end

  def current_board
    Board.find(params[:board_id])
  end

  def build_task
    current_board.tasks.build(user_id: current_user[:id])
  end

end
