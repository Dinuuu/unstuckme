module V1
	class QuestionsController < ApplicationController
    include PaginationHelper
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
      vote_params[:votes].each do |vote|
        option = Option.find(vote)
        option.update_attributes(votes: option.votes + 1)
        Answer.create(option_id: option.id, question_id: option.question_id, voter: voter)
      end
      render status: :created, json: {}
    end

    def my_questions
      render status: :ok, json: Question.for_user(user_params[:user])
    end

    def my_answers
      byebug
      render status: :ok, json: Question.where(id: Answer.where(voter: user_params[:user])
                                        .pluck(:question_id))
    end

    private

    def check_ownership
      render status: :forbidden, json: {} unless params[:creator] == question.creator
    end

    def question
      @question ||= Question.find(params[:id])
    end

    def questions_params
      params.require(:question).permit(:creator, :exclusive, options_attributes: [:option])
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
