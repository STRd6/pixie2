module ApplicationHelper
  def author_link(item)
    user = item.user

    "By #{user ? link_to(user, user) : 'Anonymous'}".html_safe
  end

  def sprite_tag_link(sprite, tag)
    render :partial => "sprites/tag", :object => tag, :locals => {:sprite => sprite}
  end

  def display_comments(commentable)
    render :partial => "shared/comments", :locals => {:commentable => commentable}
  end
end
