class MoviePolicy < ApplicationPolicy

  def pending
    user.admin = true
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
