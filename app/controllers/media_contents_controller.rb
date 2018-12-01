class MediaContentsController < ApplicationController
  $photo_url
  def create
    # @media = Media.new(file_name: params[:file])
    # if @media.save
    #   respond_to do |format|
    #     format.json{ render :json => @media }
    #   end
    # end

    uploaded_io = params[:file]
    $photo_url = Rails.root.join('public', 'uploads', uploaded_io.original_filename)
    File.open($photo_url, 'wb') do |file|
      file.write(uploaded_io.read)
    end
    

  end

  def find_url
    render :json => $photo_url 
  end

end