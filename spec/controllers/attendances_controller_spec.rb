require 'rails_helper'

RSpec.describe AttendancesController, type: :controller do

  describe "GET #index" do
    it "renders the index template" do
      assert_generates '/events/10/attendances', { controller: 'attendances', action: 'index'}
    end
  end

end

