require "spec_helper"
require "rack/test"
require_relative "../../app"

def reset_tables
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect(host: '127.0.0.1', dbname: 'chitter_test')
  connection.exec(seed_sql)
end

describe Application do
  before :each do
    reset_tables
  end

  describe "Homepage" do
    # This is so we can use rack-test helper methods.
    include Rack::Test::Methods

    let(:app) { Application.new }

    it "displays all peeps in reverse chronological order" do
      response = get('/')
      expect(response.status).to eq(200)
      expect(response.body).to match(/Big Brother is watching you @wsmith[\s\S]*@wsmith & @smhanna - this is jam hot, this is jam hot[\s\S]*We shall meet in the place where there is no darkness/)
    end
    it "Displays the peep author's name and username" do
      response = get('/')
      expect(response.body).to include("Author: @tcarmichael - Tom Carmichael-Mhanna")
      expect(response.body).to include("Author: @smhanna - Sarwah Mhanna")
    end
    it "Displays the peep's timestamp" do
      response = get('/')
      expect(response.body).to match(/On 2022-12-19 10:23:54[\s\S]*On 1984-06-15 14:33:00/)
    end

    context "When the user is logged in" do
      it "Displays the form to post a new peep" do
        # No query params, but session object is simulated
        response = get('/', {}, { 'rack.session' => { username: "tcarmichael", user_id: 1 } } )
        expect(response.status).to eq(200)
        expect(response.body).to include('<form method="POST" action="/peep">')
        expect(response.body).to include('<input type="text" name="message" />')
        expect(response.body).to include('<input type="submit" />')
      end
    end
  end
end