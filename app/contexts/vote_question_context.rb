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
      update_question(question)
    end
    Answer.create(option_id: option.id, question_id: option.question_id, voter: voter.device_token)
    voter.update_attributes(answered_questions: voter.answered_questions + 1, credits: voter.credits + 1)
  end

  private

  def give_experience_to_question_creator(questioner)
    level_before = questioner.level
    questioner.assign_attributes(experience: questioner.experience  + Answer::EXPERIENCE_PER_ANSWER)
    level_after = questioner.level
    questioner.assign_attributes(credits: questioner.credits + level_before) if level_after > level_before
    questioner.save
  end

  def update_question(question)
    new_state = question.total_votes + 1 < question.limit
    question.update_attributes(total_votes: question.total_votes + 1, active: new_state)
    questioner = User.find_by_device_token(question.creator)
    questioner.assign_attributes(my_questions_answers: questioner.my_questions_answers + 1)
    give_experience_to_question_creator(questioner)
    LimitPushContext.new(question.id).send unless new_state
  end
end
