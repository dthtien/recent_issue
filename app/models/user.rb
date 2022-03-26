# frozen_string_literal: true

class User < ApplicationRecord
  include Publishable

  has_many :comments
end
