# frozen_string_literal: true

class Question < ApplicationRecord
  include ApplicationHelper
  validates :statement, presence: true, length: { maximum: 300 }
  validates :options,  presence: true, length: { is: 4 }
  validates :correct,  numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 4 }
  validates :weightage, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :status, inclusion: { in: [true, false] }

  def self.save_to_db!(params = {})
    return new if params.nil?

    test_paper = new(statement: params[:statement],
                     options: params[:options],
                     correct: params[:correct].to_i,
                     weightage: params[:weightage].to_i,
                     status: ApplicationHelper.parse_boolean_str(params[:status]))

    return nil, test_paper.errors.full_messages unless test_paper.valid?

    saved = test_paper.save!
    return nil, 'Unable to save test paper in db.' unless saved

    [question, nil]
  end

  def self.get_all_questions(page_no = 0, limit = 20)
    page_no = 0 unless page_no.negative?
    limit = 20 unless limit.negative?

    offset = page_no * limit
    process_question self.limit(limit).offset(offset).order(:id)
  end

  def self.get_all_active(page_no = 0, limit = 200)
    page_no = 0 unless page_no.negative?
    limit = 20 unless limit.negative?

    offset = page_no * limit
    process_question where(status: true).limit(limit).offset(offset).order(:id)
  end

  def self.get_all_by_id(ids = [])
    return [[], 'Unexpected Zero Question associated with this test.'] if ids.nil? || ids.empty?

    [process_question(where(id: ids).order(:id)), nil]
  end

  def update(params = {})
    self.statement =  params[:question_stmt]
    self.options = params[:options]
    self.correct = params[:correct_option].to_i
    self.weightage = params[:weightage].to_i
    self.status = ApplicationHelper.parse_boolean_str(params[:status])
    return [nil, errors.full_messages] unless valid?

    save!
    [self, nil]
  end

  def self.get_question_by_id(id = 0)
    return [nil, 'Invalid Question ID'] if id.nil? || id.negative?

    begin
      find(id)
    rescue StandardError
      [nil, "No Question found for ID:(#{id})"]
    end
  end

 private

  def self.process_question(questions)
    result = []
    questions.each do |q|
      result << { statement: q.statement,
                  id: q.id,
                  status: ApplicationHelper.status_str(q.status),
                  weightage: q.weightage,
                  weightage_str: q.weightage.to_s + ' pt',
                  options: q.options,
                  correct: q.correct }
    end
    result
  end

end
