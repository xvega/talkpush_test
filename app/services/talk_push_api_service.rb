class TalkPushApiService

  include HTTParty

  base_uri 'https://my.talkpush.com/api/talkpush_services'
  CAMPAIGN_ID  = 3929
  API_KEY      = Rails.application.credentials.dig(:development, :talkpush, :api_key)
  CAMPAIGN_URL = (base_uri + "/campaigns/#{CAMPAIGN_ID}/campaign_invitations").freeze

  def create_candidate_request(params)
    HTTParty.post(
      CAMPAIGN_URL,
        body: {
          api_key: API_KEY,
          campaign_invitation: {
            first_name: params[:first_name],
            last_name: params[:last_name],
            email: params[:email],
            user_phone_number: params[:user_phone_number],
          },
          headers: {
            'Content-Type' => 'application/json'
          }
        }
    )
  end
end
