require 'rails_helper'

RSpec.describe UsersController, type: :request do
  before(:each) do
    @user = User.create(name: 'Javier', photo: 'Photo', bio: "Hello, I'm Javier and I'm a Physicist.")
  end

  context '/users route (GET #index)' do
    before(:each) { get users_path }

    it 'should be a success when called' do
      expect(response).to have_http_status(:ok)
    end

    it "should render index.html.erb file from views/users (render 'index' template)" do
      expect(response).to render_template('index')
    end

    it "should render the correct content in the 'index' template" do
      expect(response.body).to include('Javier')
    end
  end

  context '/users/:id route (GET #show)' do
    before(:each) { get user_path(@user) }

    it 'should be a success when called' do
      expect(response).to have_http_status(:ok)
    end

    it "should render show.html.erb file from views/users (render 'show' template)" do
      expect(response).to render_template('show')
    end

    it "should render the correct content in the 'show' template" do
      expect(response.body).to include('Physicist')
    end
  end
end
