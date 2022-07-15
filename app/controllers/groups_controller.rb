class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @book = Book.new
    @groups = Group.all
  end

  def show
    @book = Book.new
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    @group.users << current_user
    if @group.save
      redirect_to group_path(@group)
    else
      render 'new'
    end
  end

  def join
    @group = Group.find(params[:group_id])
    @group.users << current_user
    redirect_to  request.referer
  end

  def leave
    @group = Group.find(params[:group_id])
    @group.users.delete(current_user)
    redirect_to  request.referer
  end

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to groups_path
    else
      render "edit"
    end
  end






  private

  def group_params
    params.require(:group).permit(:name, :introduction)
  end

  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to groups_path
    end
  end
end
