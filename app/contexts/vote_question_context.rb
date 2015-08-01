class VoteQuestionContext
  attr_reader :voter, :vote
  def initialize(voter, vote)
    @voter = voter
    @vote = vote
  end

  def make_votation
    option = Option.find(vote)
    question = option.question
    option.update_attributes(votes: option.votes + 1)
    if question.active?
      new_state = question.total_votes + 1 < question.limit
      option.question.update_attributes(total_votes: question.total_votes + 1, active: new_state)
    end
    Answer.create(option_id: option.id, question_id: option.question_id, voter: voter)
  end
end
