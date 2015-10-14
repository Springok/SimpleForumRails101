class GroupsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    # flash[:notice] = "午安～您好！"
    # flash[:warning] = "test"
    # flash[:info]= "info"
    # flash[:danger]= "danger" 測試一下notice_message helper
    @groups = Group.all

  end

  def new
    @group = Group.new
  end

  def show
    @group = Group.find(params[:id])
    @posts = @group.posts

  end

  def edit
    @group = current_user.groups.find(params[:id])
  end

  def create
    @group = current_user.groups.create(group_params)

    if @group.save
      redirect_to groups_path, notice: "新增討論板成功"
      current_user.join!(@group)
    else
      render :new
    end


  end

  def update
    @group = current_user.groups.find(params[:id])

    if @group.update(group_params)
      redirect_to groups_path, notice: "更新討論板成功"
    else
      render :edit
    end

  end

  def destroy
    @group = current_user.groups.find(params[:id])
    @group.destroy
    redirect_to groups_path, alert: "討論板已刪除"
  end

  def join
    @group = Group.find(params[:id])

    if current_user.is_member_of?(@group)
      flash[:notice] = "您已經是本討論版的成員了喔～"
    else
      current_user.join!(@group)
      flash[:notice] = "歡迎加入！"
    end
    redirect_to group_path(@group)
  end

  def quit
    @group = Group.find(params[:id])

    if current_user.is_member_of?(@group)
      flash[:notice] = "退出討論版成功～"
      current_user.quit!(@group)
    else
      flash[:notice] = "您並非本討論版的成員啊～無法退出"
    end
    redirect_to group_path(@group)
  end

  private
  def group_params
    params.require(:group).permit( :title, :description)
  end

end
