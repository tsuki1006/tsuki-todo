class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create ]
  before_action :set_elements, only: [ :new, :create ]

  def new
    @comment = @task.comments.build(user: current_user)
  end

  def create
    @comment = @task.comments.build(user: current_user)
    @comment.assign_attributes(comment_params)
    if @comment.save
      redirect_to board_task_path(board_id: @board, id:@task), notice: '保存しました'
    else
      flash.now[:error] = '保存に失敗しました'
      render :new, status: :unprocessable_entity
    end

  end

  def set_elements
    @board = Board.find(params[:board_id])
    @task = Task.find(params[:task_id])
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end

end
