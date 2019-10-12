module GoogleDriveApi
  class SpreadsheetProcessingService

    SPREADSHEET_KEY = '1xkofJa5iI3AQE4yWEoHqMTQ1QQ-VDsfUDDwV96QQDVM'.freeze

    attr_accessor :session, :ws

    def initialize
      # config.json is generated when you run the app for the first time
      @session = GoogleDrive::Session.from_config('config.json')
      @ws = session.spreadsheet_by_key(SPREADSHEET_KEY).worksheets[0]
    end

    def request_new_candidates_creation
      new_candidates.each do |c|
        candidate_params = build_candidate_params(c)
        create_candidate(candidate_params) if candidate_params
        talk_push_request(candidate_params)
      end
    end

    def reload_ws
      ws.reload
    end

    private

    def talk_push_request(candidate_params)
      candidate_email = candidate_params.dig('email')
      talk_push_instance = TalkPushApi::TalkPushApiService.new
      response = talk_push_instance.request_candidate_creation(candidate_params)
      RequestTalkPushCandidate.create_from_response_params(response, candidate_email)
    end

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
