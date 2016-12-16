class ReviewPolicy < ApplicationPolicy
  attr_reader :user, :review, :movie

  def create?
    user
  end

  def update?
    user == record.user || user.admin
  end

  def destroy?
    user == record.user || user.admin
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
