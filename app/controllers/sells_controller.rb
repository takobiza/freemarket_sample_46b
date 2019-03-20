class SellsController < ApplicationController
  def index
    @prefectures = Prefecture.all
  end
end
