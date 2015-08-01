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
      questions = Question.where(exclusive: false).includes(:options)
      render status: :ok, json: paginate(questions)
    end

    def show
      render status: :ok, json: question
    end

    def destroy
      question.destroy
      render status: :ok, json: {}
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
	end
end
