class HomeController < ApplicationController
  def index
    spreadsheet.reload_ws
    spreadsheet.request_new_candidates_creation

    @candidates = Candidate.all

    respond_to do |format|
      format.js
      format.html
    end
  end

  def spreadsheet
    @spreadsheet ||= GoogleDriveApi::SpreadsheetProcessingService.new
  end
end