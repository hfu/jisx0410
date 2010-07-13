require 'jisx0410'

describe JISX0410, "random test" do
  before do
  end

  it "returns the level" do
    JISX0410.level_of(3241).should == JISX0410::ICHIJI
  end

  it 'encodes' do
    JISX0410.encode(138.592861, 36.314091, JISX0410::NIJI).should == '543834'
  end

  after do
  end
end
