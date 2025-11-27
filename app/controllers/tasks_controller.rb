class TasksController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :set_board, only: [ :show, :new, :create, :edit, :update, :destroy ]

  def show
    @task = @board.tasks.find(params[:id])
  end

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

  def edit
    @task = @board.tasks.find(params[:id])
  end

  def update
    @task = @board.tasks.find(params[:id])
    if @task.update(task_params)
      redirect_to board_task_path(board_id: @board, id: @task), notice: '更新しました'
    else
      flash.now[:error] = '更新に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    task = @board.tasks.find(params[:id])
    task.destroy!
    redirect_to board_path(@board), notice: '削除しました'
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
