class RelationshipsController < ApplicationController
  before_action :require_user_logged_in

  def create
    task = Task.find(params[:like_id])
    current_user.like(task)
    flash[:success] = "お気に入りに追加しました"
    redirect_to task
  end

  def destroy
    task = Task.find(params[:like_id])
    current_user.unlike(task)
    flash[:success] = "お気に入りから削除しました"
    redirect_to task
  end
end