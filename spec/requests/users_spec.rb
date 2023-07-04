require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'user index' do
    before :each do
      @user = User.create(name: 'Kelvin Kaviku',
                          photo: 'https://avatars.githubusercontent.com/u/104892694?v=4',
                          posts_counter: 1)
      get user_path(@user.id)
    end

    it 'should check if status was correct' do
      expect(response).to have_http_status(200)
    end

    it 'should check if response body includes user photo URL' do
      expect(response.body).to include(@user.photo)
    end
  end

  context 'user show' do
    before :each do
      @user = User.create(name: 'Kelvin Kaviku',
                          photo: 'https://avatars.githubusercontent.com/u/104892694?v=4',
                          bio: 'In love with Ruby on Rails.',
                          posts_counter: 1)

      # Create three posts for the user
      @user.posts.create([
                           { title: 'First Post', text: 'First post text', comments_counter: 0, likes_counter: 0 },
                           { title: 'Second Post', text: 'Second post text', comments_counter: 0, likes_counter: 0 },
                           { title: 'Third Post', text: 'Third post text', comments_counter: 0, likes_counter: 0 }
                         ])

      get user_path(@user.id)
    end

    it 'should check if status was correct' do
      expect(response).to have_http_status(200)
    end

    it 'should check if correct show template is rendered' do
      expect(response).to render_template(:show)
    end

    it 'should check if response body includes correct placeholder text' do
      expect(response.body).to include('In love with Ruby on Rails.')
    end

    it 'should check if response body includes user photo URL' do
      expect(response.body).to include(@user.photo)
    end

    it 'should display the user\'s first 3 posts' do
      expect(response.body).to include(@user.posts.first.title)
      expect(response.body).to include(@user.posts.second.title)
      expect(response.body).to include(@user.posts.third.title)
    end
  end
end
