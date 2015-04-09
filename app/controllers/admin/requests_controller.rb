class Admin::RequestsController < ApplicationController
  
  def index
    @requests = Request.all
    if @requests.any?
       puts "We have requests"
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def create
  end
  
  def update
  end
  
  def set_request
  end
  
  def request_params
    
  end
  
end
