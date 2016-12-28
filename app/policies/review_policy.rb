class ReviewPolicy < ApplicationPolicy

  def create?
    user
  end

  def update?
    user == record.user || user.admin
  end

  def destroy?
    user == record.user || user.admin
  end

  def approve?
    user.admin
  end


  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
