class QuestionQuery
  attr_reader :relation, :user
  def initialize(user, relation = Question.all )
    @relation = relation
    @user = user
  end

  def find
    @relation.where(exclusive: false)
             .where.not(id: Answer.where(voter: user).pluck(:question_id))
             .where.not(creator: user)
             .includes(:options)
  end
end
