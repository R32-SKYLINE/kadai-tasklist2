class TasksController < ApplicationController
   before_action :require_user_logged_in
   before_action :correct_user, only: [:destroy]
   #before_action :set_task, only: [:show, :edit, :update, :destroy]
   
   #def index
   #   # @tasks = Task.all
   #   @tasks = Task.order(id: :asc).all
   #end

   #def show
   #end

   #def new
   #   @task = Task.new
   #end
   
   def create
      @task = current_user.tasks.build(message_params)
      if @task.save
         flash[:success] = 'メッセージを投稿しました。'
         redirect_to root_url
      else
         @pagy, @tasks = pagy(current_user.tasks.order(id: :desc))
         flash.now[:danger] = 'メッセージの投稿に失敗しました。'
         render 'toppages/index'
      end
   end
  
   #def edit
   #end

   #def update
   #   if @task.update(message_params)
   #      flash[:success] = 'タスクが正常に更新されました。'
   #      redirect_to @task
   #   else
   #      flash.now[:danger] = 'タスクが更新されませんでした。'
   #      render :new
   #   end
   #end

   def destroy
      @task.destroy
      flash[:success] = 'タスクは正常に削除されました。'
      redirect_back(fallback_location: root_path)
   end
   
   private
   
   #def set_task
   #   @task = Task.find(params[:id])
   #end

   # Strong Parameter
   def message_params
      params.require(:task).permit(:content, :status, :user_id)
   end
   
   def correct_user
      @taks = current_user.tasks.find_by(id: params[:id])
      unless @taks
         redirect_to root_url
      end
   end
end