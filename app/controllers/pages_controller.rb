class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :request_demo ]
  def request_demo
  end
end
