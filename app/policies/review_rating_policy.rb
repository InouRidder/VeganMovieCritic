class ReviewRatingPolicy < ApplicationPolicy
  def create?
    user
  end

  def update?
    record.user == user || user.admin
  end

  def destroy?
    record.user == user || user.admin
  end

   class Scope < Scope
    def resolve
      scope.all
    end
  end
end
