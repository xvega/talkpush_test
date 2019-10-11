class CreateRequestTalkPushCandidate < ActiveRecord::Migration[6.0]
  def change
    create_table :request_talk_push_candidates do |t|
      t.string :candidate_email
      t.string :response_message
      t.string :error_message
      t.string :lead_id
      t.string :pin

      t.timestamps
    end
  end
end
