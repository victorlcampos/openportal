class HomeController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :find_all_resources
end
