class TasksController < ApplicationController
   before_action :require_user_logged_in
   before_action :correct_user, only: [:destroy]
   before_action :set_task, only: [:show, :edit, :update]
   
  def index
    if logged_in?
      @task = current_user.tasks.build  # form_with 用
      @pagy, @tasks = pagy(current_user.tasks.order(id: :desc), items: 7)
    end
  end
  
   def show
     @task = current_user.tasks.build  # form_with 用
     set_task
   end

   def new
      @task = Task.new
   end
   
   def create
      @task = current_user.tasks.build(message_params)
      if @task.save
         flash[:success] = 'タスクを登録しました。'
         redirect_to root_url
      else
         @pagy, @tasks = pagy(current_user.tasks.order(id: :desc))
         flash.now[:danger] = 'タスクの登録に失敗しました。'
         render 'tasks/index'
      end
   end
  
   def edit
      set_task
   end

   def update
      set_task
      if @task.update(message_params)
         flash[:success] = 'タスクが正常に更新されました。'
         redirect_to @task
      else
         flash.now[:danger] = 'タスクが更新されませんでした。'
         render :new
      end
   end

   def destroy
      set_task
      @task.destroy
      
      flash[:success] = 'タスクは正常に削除されました。'
      redirect_back(fallback_location: root_path)
   end
   
   private
   
   def set_task
      #binding.pry
      @task = Task.find(params[:id])
   end

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