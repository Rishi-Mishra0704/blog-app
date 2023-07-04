require 'rails_helper'

RSpec.describe 'users/index.html.erb', type: :feature do
  before(:each) do
    # Set up any necessary data or actions before each test
    user1 = User.create(name: 'Username 1', photo: 'photo1.jpg', posts_counter: 10)
    user2 = User.create(name: 'Username 2', photo: 'photo2.jpg', posts_counter: 5)
    @users = [user1, user2]
  end

  it 'displays the username of all other users' do
    visit users_path
    expect(page).to have_content('Username 1')
    expect(page).to have_content('Username 2')
    # Add more expectations as needed
  end

  it 'displays the profile picture for each user' do
    visit users_path
    expect(page).to have_css('.user-avatar img[src*="photo1.jpg"]')
    expect(page).to have_css('.user-avatar img[src*="photo2.jpg"]')
    # Add more expectations as needed
  end

  it 'displays the number of posts each user has written' do
    visit users_path
    expect(page).to have_content('Number of posts: 10')
    expect(page).to have_content('Number of posts: 5')
    # Add more expectations as needed
  end

  it 'redirects to the user show page when clicking on a user' do
    visit users_path
    click_link('Username 1')
    expect(current_path).to eq(user_path(User.find_by(name: 'Username 1')))
    # Add more expectations as needed
  end
end
