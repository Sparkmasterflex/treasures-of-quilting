module ApplicationHelper
  def preview_text(text)
    text.gsub!(/\r\n\r\n/, "")
  end

  def add_html_tags(text)
    with_tags = raw text.gsub(/\r\n\r\n/, '</p><p>').gsub(/b\[/, '<strong>').gsub(/\]b/, '</strong>').gsub(/i\[/, '<em>').gsub(/\]i/, '</em>').gsub(/h\[/, '<h3>').gsub(/\]h/, '</h3><p>')
  end

  def show_notice
    notice  = flash[:notice]
    error   = flash[:error]
    success = flash[:success]

    return raw "<p class='flash_msg success'><strong>#{success}</strong></p>" if !success.blank?
    return raw "<p class='flash_msg error'><strong>#{error}</strong></p>" if !error.blank?
    return raw "<p class='flash_msg notice'><strong>#{notice}</strong></p>" if !notice.blank?
  end

  def render_error_msg(object)
    render :partial => "shared/error_message", :locals => {:object => object} if object.errors.any?
  end

   def disabled_link(img, action)
    case action
      when 'enable' then " disabled" if img.enabled?
      when 'disable' then " disabled" unless img.enabled?
    end
  end

  # This method demonstrates the use of the :child_index option to render a
  # form partial for, for instance, client side addition of new nested
  # records.
  #
  # This specific example creates a link which uses javascript to add a new
  # form partial to the DOM.
  #
  #   <%= form_for @project do |project_form| -%>
  #     <div id="tasks">
  #       <% project_form.fields_for :tasks do |task_form| %>
  #         <%= render :partial => 'task', :locals => { :f => task_form } %>
  #       <% end %>
  #     </div>
  #   <% end -%>
  def generate_html(form_builder, method, options = {})
    options[:object] ||= form_builder.object.class.reflect_on_association(method).klass.new
    options[:partial] ||= method.to_s.singularize
    options[:form_builder_local] ||= :f

    form_builder.fields_for(method, options[:object], :child_index => 'NEW_RECORD') do |f|
      render(:partial => options[:partial], :locals => { options[:form_builder_local] => f })
    end
  end

  def generate_template(form_builder, method, options = {})
    escape_javascript generate_html(form_builder, method, options)
  end

  def link_to_destroy_nested(builder, link_text, path)
    html_class = builder.object.new_record? ? " remove_nested_item" : ""
    method = builder.object.new_record? ? nil : :delete

    raw link_to(link_text, path,
      :class => "delete icon hidden-text#{html_class}",
      :title => "#{link_text}",
      :method => method)
  end

  def render_pagination(collection, params)
    float = params[:right] ? 'floatRight' : 'floatLeft'
    will_paginate(collection, :class => "ajax pagination #{float}", :params => params) if collection.respond_to?(:total_pages) && collection.total_pages > 1
  end

  def ordered_images(images)
    images.sort_by{ |img| img.position }
  end

  def current_page(params)
    page = params[:controller] == 'webpages' ? params[:page_alias] : params[:controller]

    return page || 'home'
  end

  def is_current(obj, link)
    obj == link ? 'current' : nil
  end

  def num_columns(obj)    
    obj.has_enabled_images? ? 'leftcol' : 'contentText'
  end

  def image_display(obj)
    unless obj.images.blank?
      obj.widgets.js_slideshow ? '/widgets/js_slideshow' :
        obj.widgets.js_gallery ? '/widgets/js_gallery' :
          '/images/single_image'
    end
  end

  def has_image_display?(obj)
    obj.widgets.js_slideshow || obj.widgets.js_gallery
  end

  def display_preview(widget)
    case widget
      when Widget::Template::FEATURED_PAGE then '/widgets/featured_page'
      when Widget::Template::CONTACT then '/widgets/contact_form'
      when Widget::Template::CALCULATOR then '/widgets/calculator'
    end
  end

  def parent_object(params)
    klass = params[:controller] == 'webpages' ? 'Webpage' : 'Subpage'
    obj_id = params[:id]

    "#{klass}_#{obj_id}"
  end
end
