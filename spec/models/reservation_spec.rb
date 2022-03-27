# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe 'factory is functional' do
    it 'generates a valid model' do
      model = FactoryBot.build :reservation
      expect(model.valid?).to be true
    end
    it 'saves a valid model' do
      model = FactoryBot.build :reservation
      expect(model.save).to be_truthy
    end
  end

  context 'ActiveModel' do
    describe 'relationsips' do
      it { is_expected.to belong_to(:event) }
      it { is_expected.to belong_to(:space) }
      # it { is_expected.to belong_to(:repeat_booking) } # its optional
      # it { is_expected.to have_many(:initiatives) }
    end
    describe 'validations' do
      it { is_expected.to validate_presence_of(:start_date_time) }
      it { is_expected.to validate_presence_of(:end_date_time) }
      it { is_expected.to validate_presence_of(:start_date) }
      it { is_expected.to validate_presence_of(:start_time) }
      it { is_expected.to validate_presence_of(:end_date) }
      it { is_expected.to validate_presence_of(:end_time) }
    end
  end

  context 'ActiveRecord' do
    describe 'DB settings' do
      it { is_expected.to have_db_index(:end_date) }
      it { is_expected.to have_db_index(:start_date) }
      # it { is_expected.to validate_uniqueness_of(:host_email) }
      # it { is_expected.to validate_uniqueness_of(:host_title).
      #                       scoped_to([:host_last_name, :host_first_name]) }
    end
  end
end
