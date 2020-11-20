class User < ApplicationRecord
  def self.get_by_email_and_test_id(attr = {})
    return [nil,"Invalid request params."] if params.nil?
    return [nil,"Please enter valid Email ID"] if params[:email].nil? || params[:email].empty?
    return [nil,"Please enter valid Test ID"] if params[:test_id].nil? || params[:test_id].empty?
    begin
      user_info = where({email: attr[:email], test_papers_id: params[:test_id] }).limit(1)
    rescue NotFound
      user_info = new({email: attr[:email], test_papers_id: params[:test_id], status: "pending" })
      user_info.valid?
    end

    [user_info, nil]
  end
end
