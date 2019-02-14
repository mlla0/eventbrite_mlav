require 'rails_helper'

RSpec.describe "events/show.html.erb", type: :view do
  before { allow(controller).to receive(:current_user) { @user } }
  context 'when diplaying an event' do
    it "shows the button when is the admin" do
      @user = FactoryBot.create(:user)
      @event = FactoryBot.create(:event)
      @attendance = FactoryBot.create(:attendance)
      # assign(:event, @event)
      @admin = @event.admin
      @participations = Attendance.where(event_id: @event.id)
      @participants = []
      @participations.each do |participation|
        @participants << User.find(participation.participant_id)
      end

      def is_admin?(user)
        true
      end

      render

      expect(rendered).to match /Gestion/
    end

    it 'hides the button when not connected' do
      @user = FactoryBot.create(:user)
      @admin = FactoryBot.create(:user)
      @event = FactoryBot.create(:event)
      @attendance = FactoryBot.create(:attendance)
      # assign(:event, @event)
      @participations = Attendance.where(event_id: @event.id)
      @participants = []
      @participations.each do |participation|
        @participants << User.find(participation.participant_id)
      end

      def is_admin?(user)
        false
      end

      def is_not_linked_to(user)
        true
      end

      render

      expect(rendered).not_to match /Gestion/
    end

    it 'hides the button when already participating' do
      @user = FactoryBot.create(:user)
      @event = FactoryBot.create(:event)
      @attendance = FactoryBot.create(:attendance)
      # assign(:event, @event)
      @admin = @event.admin
      @participations = Attendance.where(event_id: @event.id)
      @participants = []
      @participations.each do |participation|
        @participants << User.find(participation.participant_id)
      end

      def is_admin?(user)
        false
      end
      def is_not_linked_to(user)
        false
      end

      render

      expect(rendered).not_to match /inscrire/
    end

    it 'shows the button when connected' do
      @user = FactoryBot.create(:user)
      @admin = FactoryBot.create(:user)
      @event = FactoryBot.create(:event)
      @attendance = FactoryBot.create(:attendance)
      # assign(:event, @event)
      @participations = Attendance.where(event_id: @event.id)
      @participants = []
      @participations.each do |participation|
        @participants << User.find(participation.participant_id)
      end

      def is_admin?(user)
        false
      end
      def is_not_linked_to(user)
        true
      end

      render

      expect(rendered).to match /inscrire/
    end

    it 'displays the details' do
      @user = FactoryBot.create(:user)
      @admin = FactoryBot.create(:user)
      @event = FactoryBot.create(:event)
      @attendance = FactoryBot.create(:attendance)
      @participations = Attendance.where(event_id: @event.id)
      @participants = []
      @participations.each do |participation|
        @participants << User.find(participation.participant_id)
      end

      def is_admin?(user)
        false
      end
      def is_not_linked_to(user)
        true
      end

      render

      expect(rendered).to match /2019-02-11 16:05:49/
      expect(rendered).to match /5/
      expect(rendered).to match /MyString/
      expect(rendered).to match /1/
    end
  end
end