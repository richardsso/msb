class MatchPolicy < ApplicationPolicy
  def show?
    true
  end

  def new?
    true
  end

  def create?
    true
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end

  def winner?
    true
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end

