class MembersController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  def index
    @users = User.all.where.not(email: admin_email)
  end

  def new
    @user = User.new
  end

  def create
    puts 'creating user!!'
    @user = User.new(member_params)

    if @user.save()
      redirect_to '/members', notice: "User was successfully added."
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(member_params)
      redirect_to '/members', notice: "User was successfully updated."
    else
      render 'edit'
    end
  end

  def show

  end

  def destroy
    puts "deleting user!"
    user = User.find(params[:id])
    if user.destroy()
      redirect_to '/members', notice: "User was successfully deleted."
    else
      redirect_to '/members', notice: "Unable to delete user."
    end
  end

  private

  def member_params
    params.require(:user).permit(:username, :email, :name, :address, :phone_number, :credit_card_number, :password, :password_confirmation)
  end

end
