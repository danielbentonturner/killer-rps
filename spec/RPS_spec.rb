require "./lib/RPS.rb"

describe 'To test Match class functionality' do
  it "creates a object with moves and results specified" do
    game = RPS::Match.new({player1_move: :scissors, player2_move: :rock})
    expect(game.player1_move).to eq(:scissors)
    expect(game.player2_move).to eq(:rock)
    expect(game.player1_result).to eq(:lose)
    expect(game.player2_result).to eq(:win)
  end
end