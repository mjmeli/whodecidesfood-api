require 'rails_helper'

# TODO: search TODO in this file

RSpec.describe Api::V1::DecisionsController, type: :controller do
  # before(:each) do
  #   @user = FactoryGirl.create :user
  #   api_authorization_header @user.auth_token
  # end

  # # INDEX
  # describe "GET #index" do
  #   before(:each) do
  #     comparison = FactoryGirl.create :comparison, owner: @user
  #     6.times { FactoryGirl.create :decision, comparison: comparison }
  #     get :index, params: { comparison_id: comparison.id }
  #   end
  #
  #   it "returns 4 decisions from the comparison" do
  #     decisions_response = json_response
  #     expect(decisions_response.length).to eql(6)
  #   end
  #
  #   it { should respond_with 200 }
  # end

  # # SHOW
  # describe "GET #show" do
  #   before(:each) do
  #     comparison = FactoryGirl.create :comparison, owner: @user
  #     4.times { FactoryGirl.create :decision, comparison: comparison }
  #     @decision = FactoryGirl.create :decision, comparison: comparison
  #     get :show, params: { comparison_id: comparison.id, id: @decision.id }
  #   end
  #
  #   it "returns the decision record matching the id" do
  #     decisions_response = json_response
  #     expect(decisions_response[:id]).to eql @decision.id
  #     # TODO: modify with correct field(s)
  #     # expect(decisions_response[:name]).to eql @decision.name
  #   end
  #
  #   it { should respond_with 200 }
  # end

  # # CREATE
  # describe "POST #create" do
  #   context "when is successfully created" do
  #     before(:each) do
  #       comparison = FactoryGirl.create :comparison, owner: @user
  #       # TODO: update
  #       # decision_params = { name: "Fake Name" }
  #       post :create, params: { comparison_id: comparison.id, decision: decision_params }
  #     end
  #
  #     it "returns the just decision record" do
  #       decisions_response = json_response
  #       expect(decisions_response[:id]).to be_present
  #       # TODO: update
  #       # expect(decisions_response[:name]).to eql("Fake Name")
  #       # expect(decisions_response[:score]).to eql(0)
  #     end
  #
  #     it { should respond_with 201 }
  #   end
  #
  #   context "when is not successfully created" do
  #     before(:each) do
  #       comparison = FactoryGirl.create :comparison, owner: @user
  #       # TODO: update
  #       # decision_params = { name: "" }
  #       post :create, params: { comparison_id: comparison.id, decision: decision_params }
  #     end
  #
  #     it "renders an errors json" do
  #       decisions_response = json_response
  #       expect(decisions_response).to have_key(:errors)
  #     end
  #
  #     it "renders the json errors on why the comparison could not be created" do
  #       decisions_response = json_response
  #       # TODO: update
  #       # expect(decisions_response[:errors][:name]).to include "can't be blank"
  #     end
  #
  #     it { should respond_with 422 }
  #   end
  # end

  # # UPDATE
  # describe "PUT/PATCH #update" do
  #   before(:each) do
  #     @comparison = FactoryGirl.create :comparison, owner: @user
  #     @decision = FactoryGirl.create :decision, comparison: @comparison
  #   end
  #
  #   context "when is successfully updated" do
  #     before(:each) do
  #       # TODO: update
  #       # patch :update, params: { comparison_id: @comparison.id,
  #       #                          id: @decision.id,
  #       #                          decision: { name: "New Name" } }
  #     end
  #
  #     it "renders the json representation for the updated decision" do
  #       decisions_response = json_response
  #       # TODO: update
  #       # expect(decisions_response[:name]).to eql "New Name"
  #     end
  #
  #     it { should respond_with 200 }
  #   end
  #
  #   context "when is not updated" do
  #     before(:each) do
  #       # TODO: update
  #       # patch :update, params: { comparison_id: @comparison.id,
  #       #                          id: @decision.id,
  #       #                          decision: { name: "" } }
  #     end
  #
  #     it "renders an errors json" do
  #       decisions_response = json_response
  #       expect(decisions_response).to have_key(:errors)
  #     end
  #
  #     it "renders the json errors on why the decision could not be created" do
  #       decisions_response = json_response
  #       # TODO: update
  #       # expect(decisions_response[:errors][:name]).to include "can't be blank"
  #     end
  #
  #     it { should respond_with 422 }
  #   end
  # end

  # # DESTROY
  # describe "DELETE #destroy" do
  #   before(:each) do
  #     @comparison = FactoryGirl.create :comparison, owner: @user
  #     @decision = FactoryGirl.create :decision, comparison: @comparison
  #     delete :destroy, params: { comparison_id: @comparison.id, id: @decision.id }
  #   end
  #
  #   it { should respond_with 204 }
  # end
end
