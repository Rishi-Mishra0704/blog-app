require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'Validations' do
    let(:user) do
      User.create(name: 'Rishi', photo: 'Image will be displayed here', bio: 'Hello guys', posts_counter: 0)
    end
    let(:post) do
      Post.create(title: 'First Post', text: 'This is my first post', author_id: user.id, comments_counter: 0,
                  likes_counter: 0)
    end

    subject { described_class.new(user:, post:) }

    it 'must contain user id' do
      subject.user_id = nil
      expect(subject).to_not be_valid
    end

    it 'must contain post id' do
      subject.post_id = nil
      expect(subject).to_not be_valid
    end

    it 'increments the likes counter of the associated post' do
      expect do
        subject.save
        post.reload
      end.to change { post.likes_counter }.by(1)
    end
  end
end
