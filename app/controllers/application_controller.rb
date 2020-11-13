class ApplicationController < ActionController::Base
    def hello 
        render html:"Hello from rajan"
    end
end
