# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RepeatBooking, type: :model do
  describe 'factory is functional' do
    it 'generates a valid model' do
      model = FactoryBot.build :repeat_booking
      expect(model.valid?).to be true
    end
    it 'saves a valid model' do
      model = FactoryBot.build :repeat_booking
      expect(model.save).to be_truthy
    end
  end

  context 'ActiveModel' do
    describe 'relationsips' do
      it { is_expected.to belong_to(:event) }
      it { is_expected.to belong_to(:space) }
      it { is_expected.to have_many(:reservations) }
    end
    describe 'validations' do
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
      it {
        is_expected.to validate_inclusion_of(:repeat_choice).in_array(ApplicationHelper::VALID_REPEAT_CHOICES).allow_blank
      }
      it {
        is_expected.to validate_inclusion_of(:repeat_ordinal).in_array(ApplicationHelper::VALID_REPEAT_ORDINALS).allow_blank
      }

      context 'valid repeat input combinations' do
        # test units
        ############
        it 'with unit-week takes no ordinal' do
          params = FactoryBot.attributes_for :repeat_booking, :fri_every_3_weeks
          model  = described_class.new(params)

          expect(model.valid?).to be true
        end
        it 'with unit-day takes no further inputs' do
          params = FactoryBot.attributes_for :repeat_booking, :every_4_days
          model  = described_class.new(params)

          expect(model.valid?).to be true
        end

        # test ordinal-this & choice-date
        #################################
        it 'with unit-year and ordinal-this to be used with choice-date' do
          params = FactoryBot.attributes_for :repeat_booking, :same_date_each_year
          model  = described_class.new(params)

          expect(model.valid?).to be true
        end
        it 'with unit-month and ordinal-this to be used with choice-date' do
          params = FactoryBot.attributes_for :repeat_booking, :same_date_every_2_months
          model  = described_class.new(params)

          expect(model.valid?).to be true
        end
      end

      context 'invalid repeat input combinations' do
        # test unit-day
        ###############
        it 'with unit-week takes no ordinal' do
          params = FactoryBot.attributes_for :repeat_booking, :fri_every_3_weeks
          params[:repeat_ordinal] = 'first'
          model = described_class.new(params)

          expect(model.valid?).to be false
        end
        it "with unit-week takes only weekday choices not ''" do
          params = FactoryBot.attributes_for :repeat_booking, :fri_every_3_weeks
          params[:repeat_choice] = 'first'
          model = described_class.new(params)

          expect(model.valid?).to be false
        end
        it "with unit-week takes only weekday choices not 'date'" do
          params = FactoryBot.attributes_for :repeat_booking, :fri_every_3_weeks
          params[:repeat_choice] = 'date'
          model = described_class.new(params)

          expect(model.valid?).to be false
        end
        ###############
        it 'with unit-day and an ordinal input' do
          params = FactoryBot.attributes_for :repeat_booking, :every_4_days
          params[:repeat_ordinal] = 'first'
          model = described_class.new(params)

          expect(model.valid?).to be false
        end
        it 'with unit-day and an choice input' do
          params = FactoryBot.attributes_for :repeat_booking, :every_4_days
          params[:repeat_choice] = 'wed'
          model = described_class.new(params)

          expect(model.valid?).to be false
        end

        # test ordinal-this with choice-date
        ####################################
        it 'with unit-year; ordinal may not be blank' do
          params = FactoryBot.attributes_for :repeat_booking, :first_mon_each_year
          params[:repeat_ordinal] = ''
          model = described_class.new(params)

          expect(model.valid?).to be false
        end
        it 'with unit-year; choice may not be blank' do
          params = FactoryBot.attributes_for :repeat_booking, :first_mon_each_year
          params[:repeat_choice] = ''
          model = described_class.new(params)

          expect(model.valid?).to be false
        end

        it 'with unit-month; ordinal may not be blank' do
          params = FactoryBot.attributes_for :repeat_booking, :second_wed_every_3_months
          params[:repeat_ordinal] = ''
          model = described_class.new(params)

          expect(model.valid?).to be false
        end
        it 'with unit-month; choice may not be blank' do
          params = FactoryBot.attributes_for :repeat_booking, :second_wed_every_3_months
          params[:repeat_choice] = ''
          model = described_class.new(params)

          expect(model.valid?).to be false
        end

        it 'with unit-week and ordinal-this to be used with choice-date' do
          params = FactoryBot.attributes_for :repeat_booking, :same_date_each_year
          params[:repeat_unit] = 'week'
          model = described_class.new(params)

          expect(model.valid?).to be false
        end
        it 'with unit-day and ordinal-this to be used with choice-date' do
          params = FactoryBot.attributes_for :repeat_booking, :same_date_every_2_months
          params[:repeat_unit] = 'day'
          model = described_class.new(params)

          expect(model.valid?).to be false
        end
        it 'with unit-year and ordinal-this to be used with choice-not date' do
          params = FactoryBot.attributes_for :repeat_booking, :same_date_each_year
          params[:repeat_choice] = 'mon'
          model = described_class.new(params)

          expect(model.valid?).to be false
        end
        it 'with unit-month and ordinal-not date to be used with choice-date' do
          params = FactoryBot.attributes_for :repeat_booking, :same_date_every_2_months
          params[:repeat_ordinal] = 'first'
          model = described_class.new(params)

          expect(model.valid?).to be false
        end
      end
    end
  end

  context 'ActiveRecord' do
    xdescribe 'DB settings' do
      # it { is_expected.to have_db_index(:host_email) }
      # it { is_expected.to validate_uniqueness_of(:host_email) }
      # it { is_expected.to validate_uniqueness_of(:host_title).
      #                       scoped_to([:host_last_name, :host_first_name]) }
    end
  end
end
