class MatchPolicy < ApplicationPolicy
  def index?
    true
  end

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

  def calculate_points?
    true
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end

