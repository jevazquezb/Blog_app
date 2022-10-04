require 'rails_helper'

RSpec.describe 'Post show page', type: :feature do
  before(:each) do
    @javier = User.create(name: 'Javier', photo: 'Photo', bio: "Hello, I'm Javier and I'm a Physicist.")

    @post = Post.create(
      title: 'Random post',
      text: 'This is my random post.',
      author_id: @javier.id
    )

    (1..8).each do |id|
      Comment.create(
        text: "This is my #{id} comment.",
        author_id: @javier.id,
        post_id: @post.id
      )
    end

    Like.create(
      author_id: @javier.id,
      post_id: @post.id
    )

    visit user_post_path(@javier, @post)
  end

  it 'should display the post\'s title' do
    expect(page).to have_content('Random post')
  end

  it 'should display the post\'s text' do
    expect(page).to have_content('This is my random post.')
  end

  it 'should display the post\'s number of comments' do
    expect(page).to have_content('Comments: 8')
  end

  it 'should display the post\'s number of likes' do
    expect(page).to have_content('Likes: 1')
  end

  it 'should display the comment\'s author' do
    expect(page).to have_content('Javier')
  end

  it 'should display the comment\'s text' do
    expect(page).to have_content('This is my 1 comment.')
  end
end
