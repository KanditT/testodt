require 'rails_helper'

RSpec.describe "/quests", type: :request do
  let(:valid_attributes) {
    {
      name: "Test Quest",
      status: true
    }
  }

  let(:invalid_attributes) {
    {
      status: nil
    }
  }

  describe "GET /index" do
    it "renders a successful response" do
      Quest.create! valid_attributes
      get quests_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      quest = Quest.create! valid_attributes
      get quest_url(quest)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_quest_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      quest = Quest.create! valid_attributes
      get edit_quest_url(quest)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Quest" do
        expect {
          post quests_url, params: { quest: valid_attributes }
        }.to change(Quest, :count).by(1)
      end

      it "redirects to the created quest" do
        post quests_url, params: { quest: valid_attributes }
        expect(response).to redirect_to(quests_url)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Quest" do
        expect {
          post quests_url, params: { quest: invalid_attributes }
        }.to change(Quest, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post quests_url, params: { quest: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        valid_attributes
      }

      it "updates the requested quest" do
        quest = Quest.create! valid_attributes
        patch quest_url(quest), params: { quest: new_attributes }
        quest.reload
        valid_attributes
      end

      it "redirects to the quest" do
        quest = Quest.create! valid_attributes
        patch quest_url(quest), params: { quest: new_attributes }
        quest.reload
        expect(response).to redirect_to(quests_url)
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        quest = Quest.create! valid_attributes
        patch quest_url(quest), params: { quest: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested quest" do
      quest = Quest.create! valid_attributes
      expect {
        delete quest_url(quest)
      }.to change(Quest, :count).by(-1)
    end

    it "redirects to the quests list" do
      quest = Quest.create! valid_attributes
      delete quest_url(quest)
      expect(response).to redirect_to(quests_url)
    end
  end
end
