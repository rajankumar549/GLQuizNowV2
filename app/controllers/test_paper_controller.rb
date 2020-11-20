class TestPaperController < ApplicationController

  def new
    @has_error = false
    @error_msg = 'Something went wrong !'
    @test_info = TestPaper.new
    @all_questions = Question.get_all_active
    render
  end

  def add_test_paper
    @error = ''
    @has_error = false
    _, error_msg = TestPaper.save_to_db!(params)

    unless error_msg.nil?
      @error_msg = error_msg
      @has_error = true
      return redirect_to :back
    end

    redirect_to '/testpaper/list'
  end

  def list
    @test_papers = TestPaper.get_all
    render
  end

  def edit
    @has_error = false
    @error_msg = 'Something went wrong !'
    @test_info, @error_msg = TestPaper.get_test_by_id?(params[:id])
    @all_questions = Question.get_all_active
    @has_error = @test_info.nil?
    return redirect :back if @has_error

    render
  end

  def update
    @has_error = false
    @error_msg = 'Something went wrong !'
    @test_info, @error_msg = TestPaper.get_test_by_id?(params[:id])

    @error_msg = "Unable to find Question for ID:#{id}" if @test_info.nil?
    return redirect_to "/testpaper/edit/#{params[:id]}" if @test_info.nil?

    @question_info, @error = @test_info.update params
    return redirect_to "/testpaper/edit/#{params[:id]}" unless @error.nil?

    redirect_to '/testpaper/list'
  end
end
