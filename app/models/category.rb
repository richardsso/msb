class Category < ApplicationRecord
  belongs_to :user

  def self.ranking_top_categories(limit)
    Category.select("name, sum(points) as points")
      .group("name")
      .order("points desc")
      .limit(limit)
  end

  def self.ranking_per_category_user_level(category, limit)
    Category.select("user_id, name, level, sum(points) as points")
      .where("name = ?", [category])
      .group("user_id, name, level")
      .order("CASE WHEN (level = 'advanced') THEN 0 WHEN (level = 'intermediate') THEN 1 ELSE 2 END, points desc")
      .limit(limit)
  end

  def self.ranking_per_category_user(category, limit)
    Category.select("user_id, name, sum(points) as points")
      .where("name = ?", [category])
      .group("user_id, name, points")
      .order("points desc")
      .limit(limit)
  end

  def self.ranking_per_user(limit)
    Category.select("user_id, sum(points) as points")
      .group("user_id")
      .order("points desc")
      .limit(limit)
  end

  def self.ranking_position(params = {})
    ranking = Category.ranking_per_category_user(params[:category], params[:limit])
    ranking.pluck(:user_id).index(params[:user_id]) + 1
  end
end
