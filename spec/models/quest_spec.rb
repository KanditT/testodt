require 'rails_helper'

RSpec.describe Quest, type: :model do
  describe 'asstributed'  do
    it 'has a name and status' do
      quest = Quest.new(name: 'Test Quest', status: true)
      expect(quest.name).to eq('Test Quest')
      expect(quest.status).to eq(true)
    end
  end
  describe 'validations' do
    it 'is valid with a name and status' do
      quest = Quest.new(name: 'Valid Quest', status: true)
      expect(quest).to be_valid
    end
    it 'is invalid without a name' do
      quest = Quest.new(status: true)
      expect(quest).not_to be_valid
      expect(quest.errors[:name]).to include("can't be blank")
    end
    it 'is valid with a status not in [true, false]' do
      quest = Quest.new(name: 'valid no Status Quest')
      expect(quest).to be_valid
    end

    it 'new not valid' do
      quest = Quest.new()
      expect(quest).not_to be_valid
      expect(quest.errors[:name]).to include("can't be blank")
    end
  end
end
