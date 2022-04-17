class Comments::MarkAsReadJob
  include Sidekiq::Job

  def perform(comment_id)
    return if running?(comment_id) # Bug raise when removing this

    comment = Comment.find(comment_id)
    sleep 1
    raise 'Already read!' if comment.reload.read?

    comment.update(read: true)
  end

  def key(id)
    "comments:mark_as_read:#{id}"
  end

  def running?(id)
    redis do |conn|
      conn.getset(key(id), true).present?
    end
  end

  def redis(&block)
    Sidekiq.redis(&block)
  end
end
