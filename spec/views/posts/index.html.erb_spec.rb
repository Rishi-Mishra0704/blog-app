require 'rails_helper'
RSpec.describe 'Post #Index Page', type: :feature do
  before(:each) do
    @user = User.create(name: 'Mondol', photo: 'https://example.jpg',
                        bio: 'He is a software engineer from Bangladesh', posts_counter: 10)
    @post = Post.create(author: @user, title: 'test post', text: 'This is my first post', likes_counter: 15,
                        comments_counter: 10)
    @comment = Comment.create(post_id: @post.id, user_id: @user.id, text: 'test comment')
    visit user_posts_path(@user)
  end

  it 'I can see the user\'s profile picture.' do
    page.has_content?(@user.photo)
  end

  it 'I can see the user\'s username.' do
    page.has_content?(@user.name)
  end

  it 'I can see the number of posts the user has written.' do
    page.has_content?(@user.posts_counter)
  end

  it 'I can see a post\'s title.' do
    page.has_content?(@post.title)
  end

end
