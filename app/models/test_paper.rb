class TestPaper < ApplicationRecord
  included ApplicationHelper
  validates :test_details, presence: true, length: { maximum: 300 }
  # validates :questions,  presence: true, length: {minimum: 10}
  validates :time_allowed, numericality: { only_integer: true, greater_than_or_equal_to: 30, less_than_or_equal_to: 180 }
  validates :status, inclusion: { in: [true, false] }

  def self.save_to_db!(params = {})
    return new if params.nil?

    test_paper = new(test_details: params[:test_details],
                     time_allowed: params[:time_allowed],
                     questions_id: params[:questions],
                     status: ApplicationHelper.parse_boolean_str(params[:status]))

    return nil, test_paper.errors.full_messages unless test_paper.valid?

    saved = test_paper.save!
    return nil, 'Unable to save test paper in db.' unless saved

    [test_paper, nil]
  end

  def self.get_all(page_no = 0, limit = 20)
    page_no = 0 if page_no.negative?
    limit = 20 if limit.negative?

    offset = page_no * limit
    process_test_info self.limit(limit).offset(offset).order(:id)
  end

  def update(params = {})
    self.test_details =  params[:test_details]
    self.time_allowed = params[:time_allowed]
    self.questions_id = params[:questions] unless params[:questions].nil?
    self.status = ApplicationHelper.parse_boolean_str(params[:status])
    return [nil, errors.full_messages] unless valid?

    save!
    [self, nil]
  end

  def self.get_test_by_id?(id)
    return nil, 'Invalid Question ID' if id.nil? || id.to_i <= 0

    begin
      find(id)
    rescue StandardError
      [nil, "Unable to find test for #{id}"]
    end
  end

  private

  def self.process_test_info(questions)
    result = []
    questions.each do |q|
      no_of_questions = 0
      no_of_questions = q.questions_id.length unless q.questions_id.nil?
      result << {:test_details => q.test_details,
                 :id => q.id,
                 :status => ApplicationHelper.status_str(q.status),
                 :no_of_questions => no_of_questions,
                 :time_allowed => "#{q.time_allowed} min",
      }
    end
    result
  end
end
