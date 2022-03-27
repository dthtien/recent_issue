# frozen_string_literal: true

class User < ApplicationRecord
  include Publishable

  has_many :comments

  class << self
    def with_comments
      joins(:comments)
    end

    def order_comment_rating
      from(
        select(%{
          DISTINCT ON (users.id) users.*, comments.rating as highest_rating
        }).with_comments,
        :users
      ).order(highest_rating: :desc)
    end
  end
end

# from(
# with_latest_job.select(%{
# DISTINCT ON (members.id) members.*, COALESCE(employment_histories.title, '') AS job_title
# }), :members)
# .order(job_title: options[:dir])

