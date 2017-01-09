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

  def most_reviewed?
    true
  end

  def partial?
    true
  end

  def pending?
    user.admin
  end

  def highrated?
    true
  end

  def newest?
    true
  end

  def top10?
    true
  end

  def rated?
    true
  end

  def alphabetical?
    true
  end

   class Scope < Scope
    def resolve
      scope.all
    end
  end
end
