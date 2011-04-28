module WebpagesHelper
  def additions_for(page)
    case page.page_alias
      when 'home' then ['slideshow_edit'] #'widget_fields',
      when 'about' then ['slideshow_edit']
    else
      []
    end
  end

  def preview_link_text(obj)
    obj.is_a?(Webpage) ? "Webpages" :
      obj.is_a?(Subpage) ? "Subpages" :
        obj.is_a?(Project) ? "Projects" :
          "Blogs"
  end

  def link_text(obj)
    obj.is_a?(Webpage) || obj.is_a?(Subpage) ? obj.page_alias :
        obj.is_a?(Project) ? obj.title :
          "Blogs"
  end

  def slide_text(text)
    text.size > 250 ? raw(truncate(text, :length => 250)) : raw(text)
  end
end
