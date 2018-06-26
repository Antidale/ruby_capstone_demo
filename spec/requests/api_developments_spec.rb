require 'rails_helper'

RSpec.describe "ApiDevelopments", type: :request do

  def parsed_body
    JSON.parse(response.body)
  end

  describe "RDBMS-backed" do
    before(:each) { Foo.delete_all}
    after(:each) { Foo.delete_all}
    it "create RDBMS-backed model" do
      foo = Foo.create(:name => "test")
      expect(Foo.find(foo.id).name).to eq("test")
    end

    it "expose API resourses under '/api'" do
      expect(foos_path).to eq("/api/foos")
    end

    it "create RDBMS-backed API" do
      foo = Foo.create(:name => "test")
      get foo_path(foo.id)
      expect(response).to have_http_status(:ok)
      expect(parsed_body["name"]).to eq("test")
    end
  end

  describe "Mongo-backed" do
    before(:each) { Bar.delete_all}
    after(:each) { Bar.delete_all}
    it "create Mongo-backed model" do
      bar = Bar.create(:name => "test")
      expect(Bar.find(bar.id).name).to eq("test")
    end

    it "expose API resourses under '/api'" do
      expect(bars_path).to eq("/api/bars")
    end

    it "create Mongo-backed API" do
      bar = Bar.create(:name => "test")
      get bar_path(bar.id)
      expect(response).to have_http_status(:ok)
      expect(parsed_body["name"]).to eq("test")
      expect(parsed_body).to include("created_at")
    end
  end


end
