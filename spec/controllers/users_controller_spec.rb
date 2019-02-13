require 'rails_helper'

RSpec.describe UsersController, type: :controller do

	describe "GET #show" do
    it "renders the show template" do  
		assert_generates '/users/1', { controller: 'users', action: 'show', id: '1' }
    end
  end

end
