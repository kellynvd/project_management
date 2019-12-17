class TasksController < ApplicationController
  before_action :find_project
  before_action :find_task, only: %i[show edit update destroy]

  def create
    @task = @project.tasks.create(task_params)

    if @task.save
      redirect_to @project
    else
      render 'new'
    end
  end

  def destroy
    if @task.destroy
      flash[:success] = 'Task was deleted'
    else
      flash[:error] = 'Task was not deleted'
    end
    redirect_to @project
  end

  private

  def find_project
    @project = Project.find(params[:project_id])
  end

  def find_task
    @task = @project.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:content)
  end
end
