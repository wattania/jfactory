class UploadController < ApplicationController
  def file_upload
    ret = {}
    begin
      upload_path = Rails.root.join 'files'
      Dir.mkdir upload_path unless Dir.exists? upload_path
      
      file_data = params[:file].tempfile.read()
      hash = Digest::SHA1.hexdigest file_data  

      file_path = Rails.root.join 'files', "#{hash}-#{params[:file].original_filename}"
      unless File.exists? file_path
        File.open file_path, "wb" do |f|
          f.write file_data
        end
      end

      ret = { hash: hash }
    rescue Exception => e
      ret = { error: e.message, backtrace: e.backtrace }
    end
    
    render json: ret
  end
end
