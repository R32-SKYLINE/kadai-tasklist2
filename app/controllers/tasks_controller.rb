class TasksController < ApplicationController
   def index
      @works = Task.all
   end

   def show
      @work = Task.find(params[:id])
   end

   def new
      @work = Task.new
   end

   def create
      @work = Task.new(message_params)
      
      if @work.save
         flash[:success] = 'タスクが正常に登録できました。'
         redirect_to @work
      else
         flash.now[:danger] = 'タスクが登録出来ませんでした。'
         render :new
      end
   end

   def edit
      @work = Task.find(params[:id])
   end

   def update
      @work = Task.find(params[:id])
      
      if @work.update(message_params)
         flash[:success] = 'タスクが正常に更新されました。'
         redirect_to @work
      else
         flash.now[:danger] = 'タスクが更新されませんでした。'
         render :new
      end
   end

   def destroy
      @work = Task.find(params[:id])
      @work.destroy
      
      flash[:success] = 'タスクは正常に削除されました。'
      redirect_to tasks_url
   end
   
   private
   
   # Strong Parameter
   def message_params
      params.require(:task).permit(:content)
   end
end