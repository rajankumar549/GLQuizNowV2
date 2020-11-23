class User < ApplicationRecord
  def self.get_by_email_and_test_id(params = {})
    return [nil,"Invalid request params."] if params.nil?

    return [nil,"Please enter valid Email ID"] if params[:email].nil? || params[:email].empty?
    return [nil,"Please enter valid Test ID"] if params[:test_id].nil? || params[:test_id].empty?

    user_info = where({email: params[:email], test_papers_id: params[:test_id]}).first
    if user_info.nil?
      user_info = User.create({ email: params[:email],
                                test_papers_id: params[:test_id],
                                name: params[:full_name] })
    end

    [user_info, nil]
  end
end
