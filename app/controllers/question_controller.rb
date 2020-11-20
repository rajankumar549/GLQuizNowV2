# frozen_string_literal: true

class QuestionController < ApplicationController

  def new
    @has_error = false
    @error_msg = 'Something went wrong !'
    @question_info = Question.new
    @action = '/question/new'
    render
  end

  def add_question
    @has_error = false
    @error_msg = 'Something went wrong !'
    @question_info = nil
    @question_info, @error_msg = Question.save_to_db! params
    return redirect :back unless @question_info.nil?

    redirect_to '/question/list'
  end

  def list
    @all_questions = Question.get_all_questions

    render
  end

  def edit
    @has_error = false
    @error_msg = 'Something went wrong !'
    @question_info = Question.new
    @action = "/question/update/#{params[:id]}"
    @question_info, @error_msg = Question.get_question_by_id params[:id].to_i
    print @error_msg,@question_info
    @has_error = @question_info.nil?
    return render if @question_info.nil?

    render
  end

  def update
    @error = ''
    @has_error = false
    @question_info, @error = Question.get_question_by_id params[:id].to_i
    @has_error = @question_info.nil?
    return redirect_to "/question/edit/#{params[:id]}" if @question_info.nil?

    @question_info, @error = @question_info.update params
    return redirect_to "/question/edit/#{params[:id]}" unless @error.nil?

    redirect_to '/question/list'
  end
end
