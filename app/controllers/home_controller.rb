class HomeController < ApplicationController
  def index; end

  def candidates
    @candidates = Candidate.all
    @talk_push_candidates = RequestTalkPushCandidate.all

    respond_to do |format|
      format.js
      format.html
    end
  end
end
