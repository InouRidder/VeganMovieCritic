class ProfilePolicy < ApplicationPolicy

  def new?
    @user
  end

  def create?
    @user
  end

  def edit?
    @user
  end

  def update?
    @user
  end

  def destroy?
    @user
  end

  def index?
    @user
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
