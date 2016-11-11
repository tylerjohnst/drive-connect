describe 'DriveHelper' do
  it 'calculates a percentage between two numbers' do
    value = DriveConnect::Helpers::Drive.percentage_between(100, 200, 10)
    expect(value).to eq 110
  end

  it 'generates an hash of these percentages' do
    hash = DriveConnect::Helpers::Drive.percentage_between_hash(100, 200)
    expect(hash[10]).to eq 110
  end

  it 'it generates a key value pair of non nil on actions' do
    hash = DriveConnect::Helpers::Drive.actions_hash
    expect(hash.length).to be < DriveConnect::ACTION_OPTIONS.length
  end


  it 'it generates a list of floats for the water turnovertimes per day' do
    array = DriveConnect::Helpers::Drive.water_turnover_options
    expect(array.first).to eq 0.5
    expect(array.last).to eq 6.0
  end
end
