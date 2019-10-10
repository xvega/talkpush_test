require 'rails_helper'

describe 'SpreadsheetProcessingService' do

  let(:test_class) do
    Class.new(GoogleDriveApi::SpreadsheetProcessingService)
  end

  let(:test_class_instance) { test_class.new }

  #TODO: Fix headers insert
  let(:first_row) { ['Timestamp', 'First Name', 'Last Name', 'Email', 'Phone number'] }
  let(:candidate) { %w(1980/10/08 John lennon jlennon@gmail.com 88888888) }
  let(:rows) { [first_row, candidate] }

  let(:last_known_update_index) do
    allow(test_class_instance).to receive(:last_known_update_index).and_return(rows.count)
  end

  context '#request_new_candidates_creation' do

    let(:ws_reloaded) { allow(test_class_instance.ws).to receive(:reload).and_return(true) }

    context 'when there are no candidates recorded' do

      let!(:new_candidates) { allow(test_class_instance).to receive(:new_candidates).and_return(rows) }

      it 'creates candidates from second row on',
         vcr: { cassette_name: 'google_drive/spreadsheet', record: :new_episodes } do
        expect do
          test_class_instance.request_new_candidates_creation
        end.to change { Candidate.count }.by(2)
      end
    end

    context 'when there are existing candidates' do
      let(:updated_candidates_array) do
        rows + %w(2019/01/01 Ringo Starr rstarr@gmail.com 88888888)
      end

      let(:new_row) { %w(2019/01/01 Ringo Starr rstarr@gmail.com 88888888) }
      let!(:new_candidates) { allow(test_class_instance).to receive(:new_candidates).and_return([new_row]) }

      it 'creates candidates from last known update on',
         vcr: { cassette_name: 'google_drive/spreadsheet', record: :new_episodes } do
        expect do
          test_class_instance.request_new_candidates_creation
        end.to change { Candidate.count }.by(1)
      end
    end
  end
end