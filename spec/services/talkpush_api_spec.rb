require 'rails_helper'

describe 'TalkPush Api' do

  let(:random_number) { rand(9999999) }

  it 'makes a request to the candidate creation endpoint',
     vcr: { cassette_name: 'talkpush/campaign', record: :new_episodes } do

    response = TalkPushApi::TalkPushApiService.new.request_candidate_creation(
        { first_name:        "first_name_test_#{random_number}",
                 last_name:         "last_name_test_#{random_number}",
                 email:             "email#{random_number}@test.com",
                 phone_number:      "#{random_number}"
        }
    )

    expect(response.response.code).to eq('200')
    expect(response.parsed_response['message']).to eq('Candidate was succesfully added to the campaign.')
  end
end
