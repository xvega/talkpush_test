class Candidate < ApplicationRecord

  # validations

  validates :email, uniqueness: true
  validates :first_name, :last_name, presence: true

  private

  def self.build_from_params(candidate_params)
    headers = %w(timestamp first_name last_name email phone_number)
    return if headers.count != candidate_params.count
    Hash[headers.zip candidate_params]
  end

  def self.create_from_params(candidate_params)
    create(candidate_params)
  end

  def self.last_candidate
    return if count.zero?
    # Yeah this is intended, I need an array with the last record
    last(1).pluck(:timestamp, :first_name, :last_name, :email, :phone_number).last
  end
end
