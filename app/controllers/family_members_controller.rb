class FamilyMembersController < ApplicationController
  before_action :set_family_menmber, only: [:edit, :show, :update, :destroy]
  
  def index
    @family_members = current_user.family_members
  end

  def new
    @family_member = FamilyMember.new
  end

  def create
    @family_member = current_user.family_members.new(family_member_params)

    if @family_member.save
      if params[:family_member][:from] == 'medical_bill'
        redirect_to new_medical_bill_path
      else
        redirect_to user_family_members_path, notice: "#{@family_member.name} を登録しました"
      end
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @family_member.update(family_member_params)
      redirect_to user_family_members_path, notice: "#{@family_member.name} を更新しました"
    else
      render :new
    end
  end
  
  def destroy
    @family_member.destroy
    if @family_member.errors.present?
      redirect_to user_family_members_path, notice: "#{@family_member.name} は関連する医療費があるため、削除できませんでした" 
    else
      redirect_to user_family_members_path, notice: "#{@family_member.name} を削除しました"
    end
  end

  private

  def family_member_params
    params.require(:family_member).permit(:name)
  end

  def set_family_menmber
    @family_member = current_user.family_members.find(params[:id])
  end
end
