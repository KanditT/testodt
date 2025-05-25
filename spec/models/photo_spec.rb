require 'rails_helper'

RSpec.describe Photo, type: :model do
  describe 'asstributed'  do
    it 'has a title' do
      quest = Photo.new(title: 'Test title', url: 'test_url.png')
      expect(quest.title).to eq('Test title')
      expect(quest.url).to eq('test_url.png')
    end

    it 'is valid with a title and url' do
      photo = Photo.new(title: 'Valid Photo', url: 'valid_photo.png')
      expect(photo).to be_valid
    end
    it 'is invalid without a title' do
      photo = Photo.new(title: nil, url: 'valid_photo.png')
      expect(photo).not_to be_valid
      expect(photo.errors[:title]).to include("can't be blank")
    end
    it 'is invalid without a url' do
      photo = Photo.new(title: 'Valid Photo', url: nil)
      expect(photo).not_to be_valid
      expect(photo.errors[:url]).to include("can't be blank")
    end
  end
end
