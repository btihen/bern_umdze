# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'factory is functional' do
    it 'generates a valid model' do
      model = FactoryBot.build :user
      expect(model.valid?).to be true
    end
    it 'saves a valid model' do
      model = FactoryBot.build :user
      expect(model.save).to be_truthy
    end
  end

  context 'ActiveModel' do
    describe 'relationsips' do
      # it { is_expected.to belong_to(:event) }
      # it { is_expected.to have_many(:reservations) }
    end
    describe 'validations' do
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_presence_of(:username) }
      it { is_expected.to validate_presence_of(:real_name) }
      it { is_expected.to validate_presence_of(:access_role) }
    end
  end

  context 'ActiveRecord' do
    describe 'DB settings' do
      it { have_db_index(:email) }
      it { have_db_index(:username) }
      it { is_expected.to have_db_column(:encrypted_password) }
      # it { is_expected.to validate_uniqueness_of(:email) }
      # it { is_expected.to validate_uniqueness_of(:username) }
      # it { is_expected.to validate_uniqueness_of(:host_title).
      #                       scoped_to([:host_last_name, :host_first_name]) }
    end
  end
end
