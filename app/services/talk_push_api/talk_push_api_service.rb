module TalkPushApi
  class TalkPushApiService

    include HTTParty

    base_uri 'https://my.talkpush.com/api/talkpush_services'
    CAMPAIGN_ID  = 3929
    API_KEY      = Rails.application.credentials.dig(:development, :talkpush, :api_key)
    CAMPAIGN_URL = (base_uri + "/campaigns/#{CAMPAIGN_ID}/campaign_invitations").freeze

    def request_candidate_creation(params)
      begin
        HTTParty.post(
          CAMPAIGN_URL,
          body: {
              api_key: API_KEY,
              campaign_invitation: {
                  first_name: params['first_name'],
                  last_name: params['last_name'],
                  email: params['email'],
                  user_phone_number: params['phone_number'],
              },
              headers: {
                  'Content-Type' => 'application/json'
              }
          }
        )
      rescue => e
        "Request failed: #{e}"
      end
    end
  end
end
