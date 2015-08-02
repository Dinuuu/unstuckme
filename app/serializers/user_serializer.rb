class UserSerializer < ActiveModel::Serializer
  attributes :id, :answered_questions, :questions_asked, :my_questions_answers, :credits, :level, :current_exp, :exp_to_level_up

  def exp_to_level_up
  	level = object.level
  	if level == 1
      20
    else
      20 * (2^(level - 2))
    end
  end

  def current_exp
    level = object.level
    if level == 1
      object.experience
    else
      object.experience - exp_to_level_up
    end
  end
end
