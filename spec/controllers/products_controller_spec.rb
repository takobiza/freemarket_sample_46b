require 'rails_helper'

describe ProductsController do
  describe 'GET #index' do
    it "indexアクションに対するビューを表示" do
      get :index
      expect(response).to render_template :index
    end
  end
end

