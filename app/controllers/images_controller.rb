class ImagesController < ApplicationController
  def update_status
    @image  = Image.find(params[:id])
    @object = @image.attachable_type.constantize.find(@image.attachable_id)
    enabled = params[:enable] == 'true'
    href = '/images/slideshow_edit'

    respond_to do |format|
      format.html {}
      format.js do
        @image.update_attribute('enabled', enabled)
        render :partial => href, :locals => {:object => @object}
      end
    end
  end

  def order
    @image = Image.find(params[:id])
    object = @image.attachable_type.constantize.find(@image.attachable_id)

    respond_to do |format|
      format.html {}
      format.js do
        @image.reorder_images(object, params[:sending].to_i)
        render :partial => '/images/slideshow_edit', :locals => {:object => object.reload}
      end
    end
  end

  def update_caption    
    @image = Image.find(params[:id])
    object = @image.attachable_type.constantize.find(@image.attachable_id)

    respond_to do |format|
      format.html {}
      format.js do
        @image.update_attribute('caption', params[:sending])
        render :partial => '/images/slideshow_edit', :locals => {:object => object.reload}
      end
    end
  end

  def destroy
    @image = Image.destroy(params[:id])

    respond_to do |format|
      format.html do
        flash[:success] = "Image has been deleted."
        redirect_to :back
      end
      format.js { render :nothing => true }
    end
  end
end
