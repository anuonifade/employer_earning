module Helper
  def validator_response(message)
    OpenStruct.new(message: message, status: :unprocessable_entity, valid?: false)
  end

  def mock_file_upload(file_path, type)
    ActionDispatch::Http::UploadedFile.new(
      tempfile: File.new(
        Rails.root + file_path,
        type: type,
        filename: File.basename(File.new(Rails.root + file_path))
      )
    )
  end
end
