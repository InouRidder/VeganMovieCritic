class ReviewPolicy < ApplicationPolicy

  def create?
    user
  end

  def update?

    user == record.user || user.try(:admin)
  end

  def destroy?
    user == record.user || user.try(:admin)
  end

  def approve?
    user.try(:admin)
  end

  def home?
    true
  end

  def landing?
    true
  end

  def thankyou?
    true
  end


  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
