require 'rails_helper'

RSpec.describe User, type: :model do
  describe "factory is functional" do
    it "generates a valid user" do
      model = FactoryBot.build :user
      expect(model.valid?).to be true
    end
    it "saves a valid user" do
      model = FactoryBot.build :user
      expect(model.save).to be_truthy
    end
  end

  describe "DB settings" do
    it { have_db_index(:email) }
    it { is_expected.to have_db_column(:encrypted_password) }
  end
end