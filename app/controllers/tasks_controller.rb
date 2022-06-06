class TasksController < ApplicationController
   before_action :set_task, only: [:show, :edit, :update, :destroy]
   
   def index
      # @tasks = Task.all
      @tasks = Task.order(id: :asc).all
   end

   def show
   end

   def new
      @task = Task.new
   end

   def create
      @task = Task.new(message_params)
      
      if @task.save
         flash[:success] = 'タスクが正常に登録できました。'
         redirect_to @task
      else
         flash.now[:danger] = 'タスクが登録出来ませんでした。'
         render :new
      end
   end

   def edit
   end

   def update
      if @task.update(message_params)
         flash[:success] = 'タスクが正常に更新されました。'
         redirect_to @task
      else
         flash.now[:danger] = 'タスクが更新されませんでした。'
         render :new
      end
   end

   def destroy
      @task.destroy
      
      flash[:success] = 'タスクは正常に削除されました。'
      redirect_to tasks_url
   end
   
   private
   
   def set_task
      @task = Task.find(params[:id])
   end

   # Strong Parameter
   def message_params
      params.require(:task).permit(:content, :status)
   end
end