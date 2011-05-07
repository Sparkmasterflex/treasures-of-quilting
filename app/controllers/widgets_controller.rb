class WidgetsController < ApplicationController

  def create    
    object = params[:type].constantize.find(params[:object_id].to_i)
    enabled = [Widget::Template::SLIDESHOW, Widget::Template::GALLERY].include? params[:widget].to_i
    unless params[:widget] == '0'
      @widget = Widget.new({:gadget_type => params[:type], :gadget_id => params[:object_id].to_i, :widget => params[:widget].to_i, :enabled => enabled})
    else      
      Widget.destroy_widget(object)
    end
    
    respond_to do |format|
      format.html {}
      format.js do
        @widget.save unless @widget.nil?
        render :partial => '/images/slideshow_edit', :locals => {:object => object.reload}
      end
    end
  end

  def update_status
    enable(Widget.find(params[:id]))
  end

  def order_widgets
    order(Widget.find(params[:id]))
  end

  def update_content
    widget = params[:widget].to_i
    obj_arr = params[:object].split('_')
    object = obj_arr[0].constantize.find(obj_arr[1])
    respond_to do |format|
      format.html {}
      format.js { render :partial => "/widgets/content_fields/#{Widget::Template::CONTENT[widget]}", :locals => {:object => object} }
    end
  end
end