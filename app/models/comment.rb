class Comment < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :post

  before_create :update_comment_count

  private

  def update_comment_count
    post.increment!(:comments_counter)
  end
end
