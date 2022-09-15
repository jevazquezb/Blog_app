require 'rails_helper'

RSpec.describe Post, type: :model do
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

  context 'For validation tests, Post' do
    it 'title should be present (not nil)' do
      post.title = nil
      expect(post).to_not be_valid
    end

    it 'title should be present (not empty string)' do
      post.title = ''
      expect(post).to_not be_valid
    end

    it "title's length should not be more than 250 characters" do
      post.title = 'a' * 251
      expect(post).to_not be_valid
    end

    it 'comments_counter should not be float' do
      post.comments_counter = 1.7
      expect(post).to_not be_valid
    end

    it 'comments_counter should not be negative' do
      post.comments_counter = -1
      expect(post).to_not be_valid
    end

    it 'likes_counter should not be float' do
      post.likes_counter = 1.7
      expect(post).to_not be_valid
    end

    it 'likes_counter should not be negative' do
      post.likes_counter = -1
      expect(post).to_not be_valid
    end
  end

  context 'recent_comments method' do
    before do
      8.times do |c|
        Comment.create(
          post: post,
          author: user,
          text: "This is my comment #{c}"
        )
      end
    end

    it 'should be present in Post model' do
      expect(post).to respond_to(:recent_comments)
    end

    it 'should return the last five posts' do
      expect(post.recent_comments.size).to eq(5)
    end
  end

  context 'update_posts_counter method' do
    before do
      post.destroy

      (1..3).each do |p|
        Post.create(
          author: user,
          title: 'Hello',
          text: "This is my post #{p}",
          comments_counter: 0,
          likes_counter: 0
        )
      end
    end

    it 'should be present in Post model' do
      expect(post).to respond_to(:update_posts_counter)
    end

    it 'should return the posts count for a specific user' do
      post.update_posts_counter
      expect(user.posts_counter).to eq(3)
    end
  end
end
