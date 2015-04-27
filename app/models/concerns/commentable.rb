module Commentable
  extend ActiveSupport::Concern

  included do
    include Rails.application.routes.url_helpers
    default_url_options = {:only_path => true}

    has_many :comments, -> { order("id DESC") },
      :as => :commentable,
      :dependent => :destroy
    has_many :recent_comments, -> { order("id DESC").limit(5) },
      :as => :commentable,
      :class_name => "Comment"
  end

  def remove_duplicate_comments!
    comments.group_by do |comment|
      [comment.commenter_id, comment.commentable_id, comment.body]
    end.each do |key, comments|
      comments.shift

      comments.each &:destroy
    end
  end

  module ClassMethods
    def remove_duplicate_comments!
      where{comments_count > 1}.each &:remove_duplicate_comments!
    end
  end
end
