require 'rails_helper'

RSpec.describe 'Post index page', type: :feature do
  before(:each) do
    @javier = User.create(name: 'Javier', photo: 'Photo', bio: "Hello, I'm Javier and I'm a Physicist.")

    (1..5).each do |id|
      Post.create(
        title: "Post #{id}",
        text: "This is my #{id} post.",
        author_id: @javier.id
      )
    end

    @fourth_post = @javier.posts.find_by(title: 'Post 4')

    (1..8).each do |id|
      Comment.create(
        text: "This is my #{id} comment.",
        author_id: @javier.id,
        post_id: @fourth_post.id
      )
    end

    visit user_posts_path(@javier)
  end

  it 'should display the username' do
    expect(page).to have_content(@javier.name)
  end

  it 'should display the user\'s photo' do
    image = page.all('img')
    expect(image.size).to eql(1)
  end

  it 'should display the user\'s post counter' do
    expect(page).to have_content('Number of posts: 5')
  end

  it 'should display posts\' title' do
    expect(page).to have_content('Post 5')
    expect(page).to have_content('Post 4')
    expect(page).to have_content('Post 3')
    expect(page).to have_content('Post 2')
    expect(page).to have_content('Post 1')
  end

  it 'should display the post\'s text' do
    expect(page).to have_content('This is my 2 post.')
  end

  it 'should display the last 5 comments of the 4th post' do
    expect(page).to have_content('This is my 8 comment.')
    expect(page).to have_content('This is my 7 comment.')
    expect(page).to have_content('This is my 6 comment.')
    expect(page).to have_content('This is my 5 comment.')
    expect(page).to have_content('This is my 4 comment.')
  end

  it 'should display the post\'s number of comments' do
    expect(page).to have_content('Comments: 8')
  end

  it 'should display the post\'s number of likes' do
    expect(page).to have_content('Likes: 0')
  end

  it 'should redirect to the posts show page when a post is clicked' do
    click_on 'Post 4'
    expect(page).to have_current_path user_post_path(@javier, @fourth_post)
    expect(page).to have_content('This is my 4 post.')
  end

  it 'should have a pagination button' do
    expect(page).to have_content('Pagination')
  end
end
