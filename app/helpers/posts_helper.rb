module PostsHelper
  def render_post_content(post)
    simple_format(post.context)
  end
end
