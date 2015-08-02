class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :options, :unlocked

  def options
  	ActiveModel::ArraySerializer
  	        .new(object.options,
  	             each_serializer: OptionSerializer)  	
  end

  def unlocked
  	UnlockedQuestion.where(user: @options[:user], question_id: object.id).exists? if @options[:user].present?
  end
end
