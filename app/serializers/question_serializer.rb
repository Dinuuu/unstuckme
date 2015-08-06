class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :options, :unlocked, :category

  def category
  	object.category.try(:name)
  end

  def options
  	ActiveModel::ArraySerializer
  	        .new(object.options,
  	             each_serializer: OptionSerializer)  	
  end

  def unlocked
  	UnlockedQuestion.where(user: @options[:user], question_id: object.id).exists? if @options[:user].present?
  end
end
