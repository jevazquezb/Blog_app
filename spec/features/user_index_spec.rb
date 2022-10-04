require 'rails_helper'

RSpec.describe 'User index page', type: :feature do
  before(:each) do
    @crysele = User.create(name: 'Crysele', photo: 'Photo', bio: "Hi, I'm Crys and I'm a Biologist.")
    @javier = User.create(name: 'Javier', photo: 'Photo', bio: "Hello, I'm Javier and I'm a Physicist.")
    Post.create(title: "Javier's post", text: "This is Javier's post.", author_id: @javier.id)
    visit root_path
  end

  it 'should display the username' do
    expect(page).to have_content(@crysele.name)
    expect(page).to have_content(@javier.name)
  end

  it 'should display the users\' photo' do
    image = page.all('img')
    expect(image.size).to eql(2)
  end

  it 'should display the user\'s posts counter' do
    expect(page).to have_content('Number of posts: 0')
    expect(page).to have_content('Number of posts: 1')
  end

  it 'should redirect to the user\'s show page when clicked' do
    click_on 'Crysele'
    expect(page).to have_current_path user_path(@crysele)
    expect(page).to have_content('Biologist')
  end
end
