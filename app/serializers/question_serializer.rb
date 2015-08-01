class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :options

  def options
  	ActiveModel::ArraySerializer
  	        .new(object.options,
  	             each_serializer: OptionSerializer)  	
  end
end
