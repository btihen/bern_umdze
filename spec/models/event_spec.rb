require 'rails_helper'

RSpec.describe Event, type: :model do

  describe "factory is functional" do
    it "generates a valid model" do
      model = FactoryBot.build :event
      expect(model.valid?).to be true
    end
    it "saves a valid model" do
      model = FactoryBot.build :event
      expect(model.save).to be_truthy
    end
  end

  context "ActiveModel" do
    describe "relationsips" do
      it { is_expected.to have_many(:reservations) }
      it { is_expected.to have_many(:spaces).through(:reservations) }
    end
    describe "validations" do
      it { is_expected.to validate_presence_of(:event_name) }
    end
  end

  context "ActiveRecord" do
    describe "DB settings" do
      it { is_expected.to have_db_index(:event_name) }
      # it { is_expected.to validate_uniqueness_of(:event_name) }
      # it { is_expected.to validate_uniqueness_of(:host_title).
      #                       scoped_to([:host_last_name, :host_first_name]) }
    end
  end

end
