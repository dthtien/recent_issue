require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    user1 = User.create(name: 'Ola')
    user2 = User.create(name: 'Hello')
    user3 = User.create(name: 'Wow')
    User.create(name: 'Bye')

    Comment.create(user: user1, rating: 1)
    Comment.create(user: user2, rating: 5)
    Comment.create(user: user2, rating: 3)
    Comment.create(user: user3, rating: 5)
    Comment.create(user: user1, rating: 2)
  end

  test '#order_comment_rating' do
    puts User.order_comment_rating.pluck(:name)
    assert_equal 3, User.order_comment_rating.to_a.size
    assert_equal %w[Wow Hello Ola].sort, User.order_comment_rating.map(&:name).sort
  end
end
