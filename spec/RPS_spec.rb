require "./lib/RPS.rb"
require 'digest/sha1'
# require "./lib/scripts/signin.rb"

describe 'To test Match class functionality' do
  it "creates a object with moves and results specified" do
    game = RPS::Match.new({player1_move: :scissors, player2_move: :rock})
    expect(game.player1_move).to eq(:scissors)
    expect(game.player2_move).to eq(:rock)
    expect(game.player1_result).to eq(:lose)
    expect(game.player2_result).to eq(:win)
  end
end

describe 'Sign in process' do 
  it "checks if username and password arguments are empty" do 
    hash = Hash.new
    hash["username"]=[]
    hash["password"]=[]
    expect(RPS::SignIn.run(hash)[:error]).to eq"Blank fields"
  end

  it "checks if username exists" do
    hash = Hash.new
    hash["username"]='bob'
    hash["password"]='79666'
    expect(RPS::SignIn.run(hash)[:error]).to eq"No such user"
  end 
end

describe 'Signup process' do
  it "checks if username and password arguments are empty" do 
    hash = Hash.new
    hash["username"]=[]
    hash["password"]=[]
    expect(RPS::SignUp.run(hash)[:error]).to eq"Blank fields"
  end

  it "checks if username exists" do
    hash = Hash.new
    hash["username"]='steve'
    hash["password"]='79666'
    hash["password_conf"]='79666'
    expect(RPS::SignUp.run(hash)[:error]).to eq"User already exists."
  end 
end