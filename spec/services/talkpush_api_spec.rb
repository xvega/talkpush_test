require 'rails_helper'

describe 'TalkPush Api' do

  let(:random_number) { rand(9999999) }

  context '#request_candidate_creation' do
    context 'when the request is successful' do
      it 'returns a successful response',
         vcr: { cassette_name: 'talkpush/campaign', record: :new_episodes } do

        response = TalkPushApi::TalkPushApiService.new.request_candidate_creation(
       {
               'first_name'   => "first_name_test_#{random_number}",
               'last_name'    => "last_name_test_#{random_number}",
               'email'        => "email#{random_number}@test.com",
               'phone_number' => "#{random_number}"
              }
          )

        expect(response.response.code).to eq('200')
        expect(response.parsed_response['message']).to eq('Candidate was succesfully added to the campaign.')
      end
    end

    context 'when the request fails' do
      context 'when params are duplicated' do
        it 'returns a bad response',
           vcr: { cassette_name: 'talkpush/dup_campaign', record: :new_episodes }  do

          TalkPushApi::TalkPushApiService.new.request_candidate_creation(
       {
               'first_name'   =>  "first_name_test",
               'last_name'    =>  "last_name_test",
               'email'        =>  "email@test.com",
               'phone_number' =>  "random string"
              }
          )

          response = TalkPushApi::TalkPushApiService.new.request_candidate_creation(
        {
                'first_name'   =>  "first_name_test",
                'last_name'    =>  "last_name_test",
                'email'        =>  "email@test.com",
                'phone_number' =>  "random string"
              }
          )

          expect(response.parsed_response['error']).to eq('duplicated')
        end
      end
    end
  end
end
