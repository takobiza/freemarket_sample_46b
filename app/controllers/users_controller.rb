class UsersController < ApplicationController
  def index
  end

  def new

  end

  def logout
  end

  def create
    binding.pry
    render new
  end
end
