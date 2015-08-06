class QuestionQuery
  attr_reader :relation, :user
  def initialize(user, relation = Question.all )
    @relation = relation
    @user = user
  end

  def find
    @relation.where(exclusive: false)
             .where.not(id: Answer.where(user: user).pluck(:question_id))
             .where.not(user: user)
             .where(active: true)
             .includes(:options)
             .order('RANDOM()')
             .first(20)
  end
end
