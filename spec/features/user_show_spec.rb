require 'rails_helper'

RSpec.describe 'User show page', type: :feature do
  before(:each) do
    @javier = User.create(name: 'Javier', photo: 'Photo', bio: "Hello, I'm Javier and I'm a Physicist.")
    (1..5).each do |id|
      Post.create(
        title: "Post #{id}",
        text: "This is my #{id} post.",
        author_id: @javier.id
      )
    end
    visit user_path(@javier)
  end

  it 'should display the username' do
    expect(page).to have_content(@javier.name)
  end

  it 'should display the users\' bio' do
    expect(page).to have_content(@javier.bio)
  end

  it 'should display the user\'s photo' do
    image = page.all('img')
    expect(image.size).to eql(1)
  end

  it 'should display the user\'s posts counter' do
    expect(page).to have_content('Number of posts: 5')
  end

  it 'should display the user\'s last 3 posts' do
    expect(page).to have_content('Post 5')
    expect(page).to have_content('Post 4')
    expect(page).to have_content('Post 3')
  end

  it 'should redirect to the posts display page when a post is clicked' do
    click_on 'Post 4'
    fourth_post = @javier.posts.find_by(title: 'Post 4')
    expect(page).to have_current_path user_post_path(@javier, fourth_post)
    expect(page).to have_content('This is my 4 post.')
  end

  it 'should have a see-all-posts link' do
    expect(page).to have_link('See all posts')
  end

  it "should redirect to the user's posts index page when see-all-posts is clicked" do
    first(:link, 'See all posts').click
    expect(page).to have_current_path user_posts_path(@javier)
    expect(page).to have_content('Post 1')
  end
end
