class ExamController < ApplicationController

  def show_exam
    @error_msg = 'Something went wrong !'
    @test_info, @error_msg = TestPaper.get_test_by_id? params[:id]
    @action = "/exam/evaluate/#{params[:id]}"
    return render unless @error_msg.nil?

    @error_msg = "This Test #{@test_info.id} has been disabled by admin." unless @test_info.status
    return render unless @error_msg.nil?

    @all_questions, @error_msg = Question.get_all_by_id(@test_info.questions_id)
    return render unless @error_msg.nil?

    render
  end

  def login_candidate
    @action = "/exam/login/#{params[:id]}"
    render
  end

  def start_exam
    @error_msg = 'Something went wrong !'
    @test_info, @error_msg = TestPaper.get_test_by_id? params[:id]
    @action = "/exam/start/#{params[:id]}"
    return render unless @error_msg.nil?

    @error_msg = "This Test #{@test_info.id} has been disabled by admin." unless @test_info.status
    return render unless @error_msg.nil?

    @user_info, @error_msg = User.get_by_email_and_test_id params
    return render unless @error_msg.nil?

    _, @error_msg = Submission.start_test_submission(@test_info, @user_info)
    return render unless @error_msg.nil?

    session[:user_id] = @user_info.id
    render
  end

  def evaluate
    print params
  end
end
