class GroupsController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_current_user, only: [:edit, :update]

  def index
    @book = Book.new
    @groups = Group.all
  end

  def show
    @book = Book.new
    @group = Group.find(params[:id])
  end

  def join
    @group = Group.find(params[:group_id])
    @group.users << current_user
    # @group.usersにcurrent_userを追加した配列
    # 配列演算子:配列を結合したり、条件分岐する演算子
    redirect_to groups_path
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    @group.users << current_user
    if @group.save
      redirect_to groups_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to groups_path
    else
      render :edit
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.users.delete(current_user)
    # 自分を削除
    redirect_to groups_path
  end
  
  def new_mail
    @group = Group.find(params[:group_id])
  end 
  
  def send_mail
    @group = Group.find(params[:group_id])
    # views/groups/new_mail.html.erbのform_withで入力された値を受け取る
    group_users = @group.users
    @title = params[:title]
    @content = params[:content]
    # このの値をEventMailerのsend_mailアクションへ渡しています。
    EventMailer.send_mail(group_users, @title, @content).deliver
  end 

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :image)
  end

  def ensure_current_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to groups_path
    end
  end


end
