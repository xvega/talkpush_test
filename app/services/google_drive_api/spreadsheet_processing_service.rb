module GoogleDriveApi
  class SpreadsheetProcessingService

    SPREADSHEET_KEY = '1xkofJa5iI3AQE4yWEoHqMTQ1QQ-VDsfUDDwV96QQDVM'.freeze

    attr_accessor :session, :ws

    # Virtual attribute to retrieve new candidates
    # from google's spreadsheet

    attr_accessor :last_known_update_index

    def initialize
      # I should handle this config file because it's super insecure
      # to have credentials on that json file. For now I'm adding it
      # to the gitignore
      @session = GoogleDrive::Session.from_config('config.json')
      @ws = session.spreadsheet_by_key(SPREADSHEET_KEY).worksheets[0]
    end

    # In the job, call reload_spreadsheet first and then this method
    def request_new_candidates_creation
      new_candidates.each do |c|
        candidate_params = build_candidate_params(c)
        create_candidate(candidate_params) if candidate_params
        # TalkPushApi::TalkPushApiService.new.request_candidate_creation(candidate_params)
      end
    end

    private

    def build_candidate_params(candidate)
      Candidate.build_from_params(candidate)
    end

    def create_candidate(candidate)
      Candidate.create_from_params(candidate)
    end

    # I don't like how I'm retrieving the last index
    # For now I'll keep it this way

    def find_last_update(ws_rows)
      last_insert = Candidate.last_candidate
      last_insert.nil? ? 1 : (ws_rows.find_index(last_insert))
    end

    def reload_ws
      ws.reload
    end

    # Setting a new start point for recording candidates
    # It's dangerous if someone changes the order of the
    # rows in the spreadsheet
    def new_candidates
      ws_rows = ws.rows
      last_index = find_last_update(ws_rows)
      ws_rows.drop(last_index)
    end
  end
end
