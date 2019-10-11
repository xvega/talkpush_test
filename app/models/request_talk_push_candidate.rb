class RequestTalkPushCandidate < ApplicationRecord

  validates :candidate_email, uniqueness: true

  private

  def self.create_from_response_params(response_params, candidate_email)
    parsed_response = response_params&.parsed_response

    request_candidate_record = new(
        {candidate_email: candidate_email,
         response_message: parsed_response.dig('message'),
         error_message: parsed_response.dig('error'),
         lead_id: parsed_response.dig('lead_id'),
         pin: parsed_response.dig('pin')
         }
    )
    request_candidate_record.save if request_candidate_record&.valid?
  end
end