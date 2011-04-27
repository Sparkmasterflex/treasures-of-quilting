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
end
