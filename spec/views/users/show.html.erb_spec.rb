require 'rails_helper'

RSpec.describe 'users/show.html.erb', type: :view do
  include Rails.application.routes.url_helpers

  before(:each) do
    @user = User.create(name: 'Username 1', photo: 'photo.jpg', posts_counter: 10, bio: 'User bio')
    @posts = [
      Post.create(title: 'Post 1', text: 'text 1', author: @user),
      Post.create(title: 'Post 2', text: 'text 2', author: @user),
      Post.create(title: 'Post 3', text: 'text 3', author: @user)
    ]
  end

  it 'displays the user profile picture' do
    render
    expect(rendered).to have_css('img[src="photo.jpg"][alt="User Photo"]')
  end

  it 'displays the user username' do
    render
    expect(rendered).to have_css('h1', text: 'Username 1')
  end

  it 'displays the number of posts the user has written' do
    render
    expect(rendered).to have_css('h3', text: 'Number of posts: 10', visible: false)
  end

  it 'displays the user bio' do
    render
    expect(rendered).to have_css('p', text: 'User bio')
  end

  it 'displays the user\'s first 3 posts' do
    render
    @posts.each do |post|
      expect(rendered).to have_content(post.title)
      expect(rendered).to have_content(post.text)
    end
  end

  it 'redirects to the post show page when clicking on a user\'s post' do
    render
    @posts.each do |post|
      expect(rendered).to have_link('View Post', href: url_for([@user, post]))
    end
  end
  

  it 'redirects to the user posts index page when clicking on "See all posts"' do
    render
    expect(rendered).to have_link('See all posts', href: user_posts_path(@user))
  end
end
