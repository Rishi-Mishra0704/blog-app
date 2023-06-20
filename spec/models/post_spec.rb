# Tests Comments
require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Validations' do
    let(:user) do
      User.create(name: 'Rishi', photo: 'Image will be displayed here', bio: 'Hello guys', posts_counter: 0)
    end
    let(:post) do
      Post.create(title: 'First Post', text: 'This is my first post', author_id: user.id, comments_counter: 0,
                  likes_counter: 0)
    end

    it 'Must have a title' do
      post.title = nil
      expect(post).to_not be_valid
    end

    it 'Invalid if more than 250 characters' do
      post = Post.create(
        title: 'sdghjashgdjahsgjdahsgjdahgsjdsgjashdgjshgjash
        gdjashgdjashgddfdjhkjdhkjdhfkjdhksjdhfyujashgdjashgd
        jashgdjashgvcbvndasdasdasdadvcvbnmeurioeuroeirueoirueoriue
        ordjashdgasjhdgjashdgjashdgagellodfdhjdhkfjoeimamsdhst
        ypidfndfhjskjdsomthing', text: 'This is my first post', author_id: user.id
      )
      expect(post).to_not be_valid
    end

    it 'likes_counter should be greater than or equal to 0' do
      post.likes_counter = -1
      expect(post).to_not be_valid
    end

    it 'likes_counter should be an integer' do
      post.likes_counter = 0.5
      expect(post).to_not be_valid
    end

    it 'comments_counter should be greater than or equal to 0' do
      post.comments_counter = -5
      expect(post).to_not be_valid
    end

    it 'comments_counter should be an integer' do
      post.comments_counter = 0.7
      expect(post).to_not be_valid
    end
    describe 'Post counter' do
      it 'should belong to the correct user' do
        expect(post.author).to eql user
      end

      it 'should update counter of related user' do
        post.update_posts_count
        expect(post.author.reload.posts_counter).to eql 2
      end
    end
    describe 'recent_five_comments' do
      let(:user) do
        User.create(name: 'Rishi', photo: 'Image will be displayed here', bio: 'Hello guys', posts_counter: 0)
      end
      let(:post) do
        Post.create(title: 'First Post', text: 'This is my first post', author_id: user.id, comments_counter: 0,
                    likes_counter: 0)
      end
      it 'returns the five most recent comments' do
        # Create a post
        post = Post.create(title: 'First Post', text: 'This is my first post', author_id: user.id, comments_counter: 0,
                           likes_counter: 0)

        # Create some sample comments with different created_at timestamps and associate them with the post
        comment1 = Comment.create(created_at: 1.day.ago, post:)
        comment2 = Comment.create(created_at: 2.days.ago, post:)
        comment3 = Comment.create(created_at: 3.days.ago, post:)
        comment4 = Comment.create(created_at: 4.days.ago, post:)
        comment5 = Comment.create(created_at: 5.days.ago, post:)
        Comment.create(created_at: 6.days.ago, post:)

        # Ensure the method returns the five most recent comments
        expect(post.recent_five_comments).to eq([comment5, comment4, comment3, comment2, comment1])
      end
    end
  end
end
