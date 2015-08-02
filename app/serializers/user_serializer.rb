class UserSerializer < ActiveModel::Serializer
  attributes :id, :answered_questions, :questions_asked, :my_questions_answers, :credits
end
