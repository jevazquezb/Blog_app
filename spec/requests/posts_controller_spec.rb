require 'rails_helper'

RSpec.describe PostsController, type: :request do
  before(:each) do
    @user = User.create(name: 'Javier', photo: 'Photo', bio: "Hello, I'm Javier and I'm a Physicist.")
    @post = Post.create(title: 'Random Post', text: 'This is a random post.', author_id: @user.id)
  end

  context '/users/:user_id/posts route (GET #index)' do
    before(:each) { get user_posts_path(@user) }

    it 'should be a success when called' do
      expect(response).to have_http_status(:ok)
    end

    it "should render index.html.erb file from views/posts (render 'index' template)" do
      expect(response).to render_template('index')
    end

    it "should render the correct content in the 'index' template" do
      expect(response.body).to include('Random Post')
    end
  end

  context '/users/:user_id/posts/:id route (GET #show)' do
    before(:each) { get user_post_path(@user, @post) }

    it 'should be a success when called' do
      expect(response).to have_http_status(:ok)
    end

    it "should render show.html.erb file from views/posts (render 'show' template)" do
      expect(response).to render_template('show')
    end

    it "should render the correct content in the 'show' template" do
      expect(response.body).to include('This is a random post')
    end
  end
end
