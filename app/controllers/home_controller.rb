class HomeController < ApplicationController
  def index; end

  def candidates
    #FIXME these 2 lines (and spreadsheet method) belong to the cron job task, not here.
    spreadsheet.reload_ws
    spreadsheet.request_new_candidates_creation

    @candidates = Candidate.all
    @talk_push_candidates = RequestTalkPushCandidate.all

    respond_to do |format|
      format.js
      format.html
    end
  end

  def spreadsheet
    @spreadsheet ||= GoogleDriveApi::SpreadsheetProcessingService.new
  end
end
