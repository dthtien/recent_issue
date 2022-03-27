unless User.any?
  user1 = User.create(name: 'Ola')
  user2 = User.create(name: 'Hello')
  user3 = User.create(name: 'Wow')
  User.create(name: 'Bye')
end

unless Comment.any?
  Comment.create(user: user1, rating: 1)
  Comment.create(user: user2, rating: 5)
  Comment.create(user: user2, rating: 3)
  Comment.create(user: user3, rating: 5)
  Comment.create(user: user1, rating: 2)
  1000.times do
    Comment.create(user: User.all.sample, rating: rand(1..5))
  end
end

Comment.find_each { |comment| Comments::MarkAsReadJob.perform_async(comment.id) }
