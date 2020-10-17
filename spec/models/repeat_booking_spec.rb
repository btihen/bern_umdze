require 'rails_helper'

RSpec.describe RepeatBooking, type: :model do

  describe "factory is functional" do
    it "generates a valid model" do
      model = FactoryBot.build :repeat_booking
      expect(model.valid?).to be true
    end
    it "saves a valid model" do
      model = FactoryBot.build :repeat_booking
      expect(model.save).to be_truthy
    end
  end

  context "ActiveModel" do
    describe "relationsips" do
      it { is_expected.to belong_to(:event) }
      it { is_expected.to belong_to(:space) }
      it { is_expected.to have_many(:reservations) }
    end
    describe "validations" do
      it { is_expected.to validate_presence_of(:start_date_time) }
      it { is_expected.to validate_presence_of(:end_date_time) }
      it { is_expected.to validate_presence_of(:start_date) }
      it { is_expected.to validate_presence_of(:start_time) }
      it { is_expected.to validate_presence_of(:end_date) }
      it { is_expected.to validate_presence_of(:end_time) }

      # repeat inputs
      it { is_expected.to validate_presence_of(:repeat_unit) }
      it { is_expected.to validate_presence_of(:repeat_every) }
      it { is_expected.to validate_presence_of(:repeat_until_date) }

      it { is_expected.to validate_inclusion_of(:repeat_unit).in_array(ApplicationHelper::VALID_REPEAT_UNITS) }
      it { is_expected.to validate_inclusion_of(:repeat_every).in_array(ApplicationHelper::VALID_REPEAT_EVERY) }
      it { is_expected.to validate_inclusion_of(:repeat_choice).in_array(ApplicationHelper::VALID_REPEAT_CHOICES).allow_blank }
      it { is_expected.to validate_inclusion_of(:repeat_ordinal).in_array(ApplicationHelper::VALID_REPEAT_ORDINALS).allow_blank }

      context "validate repeat input combinations" do
        
      end
    end
  end

  context "ActiveRecord" do
    xdescribe "DB settings" do
      # it { is_expected.to have_db_index(:host_email) }
      # it { is_expected.to validate_uniqueness_of(:host_email) }
      # it { is_expected.to validate_uniqueness_of(:host_title).
      #                       scoped_to([:host_last_name, :host_first_name]) }
    end
  end

end
