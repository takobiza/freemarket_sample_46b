class ProfilesController < ApplicationController

  add_breadcrumb 'メルカリ ', '/'

  def index
    add_breadcrumb "マイページ"
  end
end
