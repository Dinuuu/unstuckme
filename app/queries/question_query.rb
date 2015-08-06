class QuestionQuery
  attr_reader :relation, :user
  def initialize(user, relation = Question.all )
    @relation = relation
    @user = user
  end

  def find
    relation.not_exclusive.not_mine(user).active
            .not_answered(user)
            .includes(:options, :category)
            .order('RANDOM()')
            .first(20)
  end
end
