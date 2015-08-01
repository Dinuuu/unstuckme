module V1
	class QuestionsController < ApplicationController
    include PaginationHelper
    before_action :check_user_creation, only: [:create, :vote]
    before_action :check_ownership, only: [:destroy]


    def create
      @question = Question.new(questions_params)
      if question.save
        render status: :created, json: question
      else
        render json: { errors: question.errors }, status: :precondition_failed
      end
    end

    def index
      render status: :ok, json: paginate(QuestionQuery.new(user_params[:user]).find)
    end

    def show
      render status: :ok, json: question
    end

    def destroy
      question.destroy
      render status: :ok, json: {}
    end

    def vote
      voter = vote_params[:voter]
      return render status: :bad_request, json: {} unless voter.present?
      vote_params[:votes].each do |vote|
        VoteQuestionContext.new(voter, vote).make_votation
      end
      render status: :created, json: {}
    end

    def my_questions
      render status: :ok, json: paginate(Question.for_user(user_params[:user]))
    end

    def my_answers
      render status: :ok, json: paginate(Question.where(id: Answer.where(voter: user_params[:user])
                                         .pluck(:question_id)))
    end

    private

    def check_user_creation
      user_device = params[:question].present? ? questions_params[:creator] : vote_params[:voter]
      User.create(device_token: user_device) if user_device.present?
    end

    def check_ownership
      render status: :forbidden, json: {} unless params[:creator] == question.creator
    end

    def question
      @question ||= Question.find(params[:id])
    end

    def questions_params
      params.require(:question).permit(:creator, :exclusive, :limit, options_attributes: [:option])
    end

    def vote_params
      params.require(:votation).permit(:voter, votes:[])
    end

    def user_params
      params.require(:user)
      params.permit(:user)
    end
	end
end
