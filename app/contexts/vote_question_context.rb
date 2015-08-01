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
      question.update_attributes(total_votes: question.total_votes + 1, active: new_state)
      questioner = User.find_by_device_token(question.creator)
      questioner.update_attributes(my_questions_answers: questioner.my_questions_answers + 1)
      LimitPushContext.new(question.id).send unless new_state
    end
    Answer.create(option_id: option.id, question_id: option.question_id, voter: voter.device_token)
    voter.update_attributes(answered_questions: voter.answered_questions + 1)

  end
end
