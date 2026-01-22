class AnswersController < ApplicationController
  before_action :set_answer, only: %i[ show edit update destroy ]

  def index
    @answers = Answer.all
  end

  def show
  end

  def edit
  end

  def update
    if @answer.update(answer_params)
      redirect_to @answer
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def new
    @answer = Answer.new
  end

  def create
    @answer = Answer.new(answer_params)
    if @answer.save
      redirect_to @answer
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @answer.destroy
    redirect_to answers_path
  end

  private
    def set_answer
      @answer = Answer.find(params[:id])
    end
    def answer_params
      params.expect(answer: [ :content ])
    end
end
