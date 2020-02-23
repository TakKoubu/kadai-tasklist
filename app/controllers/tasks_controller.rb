class TasksController < ApplicationController
    before_action :require_user_logged_in
    before_action :correct_user, only: [:edit, :update, :destroy]
    
    def index
        @tasks = Task.all
        @user = User.find_by(id: params[:id])
    end
    
    def show
        @task = Task.find_by(id: params[:id])
        @user = @task.user
    end
    
    def new
        @task = current_user.tasks.build
    end
    
    def create
        @task = current_user.tasks.build(task_params)
        
        if @task.save
            flash[:success] = "保存成功"
            redirect_to root_url
        else
            @tasks = current_user.tasks.order(id: :desc).page(params[:page])
            flash[:danger] = "保存失敗"
            render :new
        end
    end
    
    def edit
    end
    
    def update
        if @task.update(task_params)
            flash[:success] = "更新成功"
            redirect_to root_url
        else
            flash[:danger] = "更新失敗"
            render :edit
        end
    end
    
    def destroy
        @task.destroy
        flash[:success] = "削除成功"
        redirect_back(fallback_location: root_path)
    end
    
    private
    
    def task_params
        params.require(:task).permit(:content, :status, :user_id)
    end
    
    def correct_user
        @task = current_user.tasks.find_by(id: params[:id])
        unless @task
            redirect_to root_url
        end
    end
end