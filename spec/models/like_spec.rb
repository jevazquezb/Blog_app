require 'rails_helper'

RSpec.describe Like, type: :model do
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

  subject(:like) do
    Like.create(
      post: post,
      author: user
    )
  end

  context 'update_likes_counter method' do
    before do
      like.destroy

      3.times do
        Like.create(
          post: post,
          author: user
        )
      end
    end

    it 'should be present in Like model' do
      expect(like).to respond_to(:update_likes_counter)
    end

    it 'should return the likes count for a specific post' do
      like.update_likes_counter
      expect(post.likes_counter).to eq(3)
    end
  end
end
