module V1
	class QuestionsController < AuthenticatedApiController
    include PaginationHelper
    before_action :check_ownership, only: [:destroy]

    def create
      @question = Question.new(questions_params.merge(user: @user))
      if question.save
        @user.update_attributes(questions_asked: @user.questions_asked + 1)
        render status: :created, json: question
      else
        render json: { errors: question.errors }, status: :precondition_failed
      end
    end

    def index
      render status: :ok, json: QuestionQuery.new(@user).find
    end

    def show
      render status: :ok, json: question
    end

    def destroy
      question.destroy
      render status: :ok, json: {}
    end

    def vote
      return render status: :bad_request, json: {} unless @user.present?
      vote_params[:votes].each do |vote|
        VoteQuestionContext.new(@user, vote).make_votation
      end
      render status: :created, json: {}
    end

    def my_questions
      render status: :ok, json: paginate(Question.for_user(@user))
    end

    def my_answers
      render status: :ok, json: paginate(Question.where(id: Answer.for_user(@user)
                                         .pluck(:question_id)))
    end

    def unlock
      question = Question.find(params[:question_id])
      return render status: :precondition_failed, json: {} if @user.credits < question.credits_for_unlock(@user) || question_already_unlocked?
      UnlockedQuestion.create(question_id: params[:question_id], user_id: @user.id)
      @user.update_attributes(credits: @user.credits - question.credits_for_unlock(@user))
      render status: :ok, json: {}
    end

    private

    def question_already_unlocked?
      UnlockedQuestion.where(question_id: params[:question_id], user_id: @user.id).exists?
    end

    def check_ownership
      render status: :forbidden, json: {} unless question.user == @user
    end

    def question
      @question ||= Question.find(params[:id])
    end

    def questions_params
      params.require(:question).permit(:exclusive, :limit, :category_id, options_attributes: [:option])
    end

    def vote_params
      params.require(:votes)
      params.permit(votes:[])
    end

    def default_serializer_options  
      { user: @user }  
    end
	end
end
