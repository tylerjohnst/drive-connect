describe 'Director' do
  it 'fetches all the directors with a collection proxy' do
    expect(DriveConnect::Models::Director.all!).to be_a DriveConnect::Models::CollectionProxy
  end
end
