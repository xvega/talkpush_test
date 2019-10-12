desc 'log'

task log_to_console: :environment do
  require File.dirname(__FILE__) + "/../../app/services/google_drive_api/spreadsheet_processing_service"

  def spreadsheet
    @spreadsheet ||= GoogleDriveApi::SpreadsheetProcessingService.new
  end

  spreadsheet.reload_ws
  spreadsheet.request_new_candidates_creation

  puts "Logging candidates...."
end
