class TasksController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create ]
  before_action :set_board, only: [ :new, :create ]

  def new
    @task = @board.tasks.build(user: current_user)
  end

  def create
    @task = @board.tasks.build(task_params)
    @task.user = current_user
    if @task.save
      redirect_to board_path(@board), notice: '保存しました'
    else
      flash.now[:error] = '保存に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def set_board
    @board = Board.find(params[:board_id])
  end

  private
  def task_params
    params.require(:task).permit(
      :title,
      :content,
      :deadline,
      :image
    )
  end

end
