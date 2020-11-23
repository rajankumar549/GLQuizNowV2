class Submission < ApplicationRecord
  def self.start_test_submission(testpaper = TestPaper, user = User)
    return [nil,nil, "Invalid Test info or User found"] if testpaper.nil? || user.nil?
    questions, err = Question.get_all_by_id(testpaper.questions_id)
    return [nil, nil, "Zero Question found for the test #{testpaper.id}"] unless err.nil?

    total_marks = 0
    questions.each do |q|
      total_marks += q[:weightage].to_i if q[:status]
    end

    sub = where({ test_papers_id: testpaper.id, users_id: user.id }).first
    sub = create({ test_papers_id: testpaper.id,users_id: user.id,status:"pending",total:total_marks,result:0 }) if sub.nil?
    return [sub,questions, "This Test Aready been Submitted"] unless sub.status == "pending"

    [sub, questions, nil]
  end

  def self.complete(test_paper = TestPaper, user = User, params = {})
    return [nil, "Invalid Test info or User found"] if test_paper.nil? || user.nil?

    test_paper = TestPaper.new(test_paper) unless test_paper.nil?
    user = User.new(user) unless user.nil?

    questions, err = Question.get_all_by_id(test_paper.questions_id)
    return [nil, "Zero Question found for the test #{test_paper.id}"] unless err.nil?
    question_to_id = {}
    questions.each do |q|
      question_to_id[q[:id]] = q
    end
    user_opts = []
    user_opts = params[:opt] unless params[:opt].nil?
    total_marks = 0

    user_opts.each do |question_id,option_selected|
      ques = question_to_id[question_id.to_i]
      total_marks += ques[:weightage] if !ques.nil? && ques[:correct] == option_selected
    end

    sub = where({ test_papers_id: test_paper.id, users_id: user.id }).first
    sub.result = total_marks
    sub.status = "completed"
    return [sub, "Unable to submitted test. Try again !!!"] unless sub.save!
    [sub, nil]
  end

  def time_left
   ((Time.now - self.created_at) * 24 * 60).to_i
  end
end
