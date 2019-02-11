require 'rails_helper'
require 'time'
require 'date'

RSpec.describe Event, type: :model do

  before(:each) do 
		@event = FactoryBot.create(:event)  	
  end

  it "has a valid factory" do
    expect(build(:event)).to be_valid
  end

  context "validation" do
    it "is valid with valid attributes" do
      expect(@event).to be_a(Event)
    end

    describe "#duration" do
      it "is not valid if duration is not a multiple of 5" do
        invalid_duration = FactoryBot.build(:event, duration: 11)
        expect(invalid_duration).not_to be_valid
        expect(invalid_duration.errors.include?(:duration)).to eq(true)
      end
      it "is not valid if duration is under 0" do
        invalid_duration = FactoryBot.build(:event, duration: -5)
        expect(invalid_duration).not_to be_valid
        expect(invalid_duration.errors.include?(:duration)).to eq(true)
      end
    end

    describe "#title" do
      it { expect(@event).to validate_presence_of(:title) }
      it "is not valid if title is under 5 characters" do
        invalid_title = FactoryBot.build(:event, title: "aa")
        expect(invalid_title).not_to be_valid
        expect(invalid_title.errors.include?(:title)).to eq(true)
      end
      it "is not valid if title is over 140 characters" do
        invalid_title = FactoryBot.build(:event, title: Faker::Hipster.paragraph(25))
        expect(invalid_title).not_to be_valid
        expect(invalid_title.errors.include?(:title)).to eq(true)
      end
    end

    describe "#description" do
      it { expect(@event).to validate_presence_of(:description) }
      it "is not valid if description is under 20 characters" do
        invalid_description = FactoryBot.build(:event, description: "aa")
        expect(invalid_description).not_to be_valid
        expect(invalid_description.errors.include?(:description)).to eq(true)
      end
      it "is not valid if description is over 1000 characters" do
        invalid_description = FactoryBot.build(:event, description: Faker::Hipster.paragraph(25))
        expect(invalid_description).not_to be_valid
        expect(invalid_description.errors.include?(:description)).to eq(true)
      end
    end

    describe "#price" do
      it { expect(@event).to validate_presence_of(:price) }
      it "is not valid if price is under 1 €" do
        invalid_price = FactoryBot.build(:event, price: 0)
        expect(invalid_price).not_to be_valid
        expect(invalid_price.errors.include?(:price)).to eq(true)
      end
      it "is not valid if price is over 1000 €" do
        invalid_price = FactoryBot.build(:event, price: 1500)
        expect(invalid_price).not_to be_valid
        expect(invalid_price.errors.include?(:price)).to eq(true)
      end
    end

    describe "#location" do
      it { expect(@event).to validate_presence_of(:location) }
    end

  end

  context "associations" do
    it { expect(@event).to belong_to(:admin).class_name('User') }
  end

  context "public instance methods" do

    describe "#start_date_is_after_time_now" do
      it "should return nil if date is in the future" do
        now = Time.now
        event = FactoryBot.create(:event, start_date: now + 1.day)
        expect(event.start_date_is_after_time_now).to eq(nil)
      end

      it "should return error if date is in the past" do
        now = Time.now
        event = FactoryBot.build(:event, start_date: now - 1.day)
        expect(event.start_date_is_after_time_now.include?("must be before time now.")).to eq(true)
      end
    end

    describe "#duration_is_multiple_of_5" do
      it "should return nil if duration is multiple of 5" do
        event = FactoryBot.create(:event, duration: 55)
        expect(event.duration_is_multiple_of_5).to eq(nil)
      end

      it "should return error if duration is not multiple of 5" do
        event = FactoryBot.build(:event, duration: 2)
        expect(event.duration_is_multiple_of_5.include?("must be multiple of five.")).to eq(true)
      end
    end

  end

end