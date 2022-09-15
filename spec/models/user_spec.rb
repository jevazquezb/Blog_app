require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) do
    User.create(
      name: 'Jesús',
      photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
      bio: 'Programmer from Mexico.',
      posts_counter: 0
    )
  end

  context 'For validation tests, User' do
    it 'name should be present (not nil)' do
      user.name = nil
      expect(user).to_not be_valid
    end

    it 'name should be present (not empty string)' do
      user.name = ''
      expect(user).to_not be_valid
    end

    it 'name should not be too short' do
      user.name = 'a'
      expect(user).to_not be_valid
    end

    it 'posts_counter should not be float' do
      user.posts_counter = 1.7
      expect(user).to_not be_valid
    end

    it 'posts_counter should not be negative' do
      user.posts_counter = -1
      expect(user).to_not be_valid
    end
  end

  context "For method's tests," do
    before do
      5.times do |p|
        Post.create(
          author: user,
          title: 'Hello',
          text: "This is my post #{p}",
          comments_counter: 0,
          likes_counter: 0
        )
      end
    end

    it 'User should have a recent_posts method' do
      expect(user).to respond_to(:recent_posts)
    end

    it 'recent_posts should return the last three posts' do
      expect(user.recent_posts.count).to eq(3)
    end
  end
end
