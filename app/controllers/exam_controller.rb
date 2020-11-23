class ExamController < ApplicationController

  def show_exam

    @error_msg = 'Something went wrong !'
    return redirect_to '/exam/candidate/login' if params[:test_id].nil?

    @test_info, @error_msg = TestPaper.get_test_by_id? params[:test_id]
    @action = "/exam/result/#{params[:test_id]}"
    return render unless @error_msg.nil?

    @error_msg = "This Test #{@test_info.id} has been disabled by admin." unless @test_info.status
    return render unless @error_msg.nil?

    @user_info, @error_msg = User.get_by_email_and_test_id params
    return render unless @error_msg.nil? || !@user_info.nil?

    sub,@all_questions, @error_msg = Submission.start_test_submission(@test_info, @user_info)
    return render unless @error_msg.nil?
    #@time_left = sub.time_left
    session[:user] = @user_info
    session[:test_info] = @test_info
    render

  end

  def login_candidate
    @action = "/exam/start"
    session[:user] = nil
    session[:test_info] = nil
    render
  end


  def result

    return redirect_to '/exam/candidate/login' if session[:user].nil? || session[:test_info].nil?
    @sub, @error_msg = Submission.complete(session[:test_info],session[:user],params)

    @test_info = TestPaper.new(session[:test_info])
    @user_info = User.new(session[:user])

    return redirect_to '/exam/candidate/login' unless @error_msg.nil?

    render "evaluate"
  end

  def result2
    render "evaluate"
  end
end
