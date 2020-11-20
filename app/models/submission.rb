class Submission < ApplicationRecord
  def self.start_test_submission(testpaper = TestPaper, user = User)
    return [nil, "Invalid Test info or User found"] if testpaper.nil? || user.nil?
    questions, err = Question.get_all_by_id(testpaper.questions)
    return [nil, "Zero Question found for the test #{testpaper.id}"] unless err.nil?
    total_marks = 0
    questions.each do |q|
      total_marks += q.weightage if q.status
    end

    sub = new({test_papers_id: testpaper.id,users_id: user.id,status:"pending",total:total_marks,result:0})
    return nil, test_paper.errors.full_messages unless sub.valid?

    saved = sub.save!
    return nil, 'Unable to create initial submission ' unless saved

    [sub, nil]
  end
end
