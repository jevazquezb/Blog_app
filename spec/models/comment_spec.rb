require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject(:user) do
    User.create(
      name: 'Jesús',
      photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
      bio: 'Programmer from Mexico.',
      posts_counter: 0
    )
  end

  subject(:post) do
    Post.create(
      author: user,
      title: 'Hello',
      text: 'This is my first post',
      comments_counter: 0,
      likes_counter: 0
    )
  end

  subject(:comment) do
    Comment.create(
      post: post,
      author: user,
      text: 'This is my first comment'
    )
  end

  context 'update_comments_counter method' do
    before do
      comment.destroy

      (1..3).each do |c|
        Comment.create(
          post: post,
          author: user,
          text: "This is my comment #{c}"
        )
      end
    end

    it 'should be present in Comment model' do
      expect(comment).to respond_to(:update_comments_counter)
    end

    it 'should return the comments count for a specific post' do
      comment.update_comments_counter
      expect(post.comments_counter).to eq(3)
    end
  end
end
