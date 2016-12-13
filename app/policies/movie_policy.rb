class MoviePolicy < ApplicationPolicy

  def create?
    user
  end

  def update?
    user.admin
  end

  def destroy?
    user.admin
  end

   class Scope < Scope
    def resolve
      scope.all
    end
  end
end
