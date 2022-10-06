class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  belongs_to :author, class_name: 'User'
  validates :title, presence: true, length: { maximum: 250, too_long: '%<count>s characters is the maximum allowed' }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_save :update_posts_counter
  after_destroy :update_posts_counter

  def update_posts_counter
    author.update(posts_counter: author.posts.count)
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
