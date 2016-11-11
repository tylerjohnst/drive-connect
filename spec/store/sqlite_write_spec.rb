describe 'Updater' do
  let(:drive) { build(:drive) }
  let(:database) { DriveConnect::Store::Database.new(':memory:') }
  let(:updater) { DriveConnect::Store::SQLite::Write.new(drive) }

  before(:each) do
    allow(updater).to receive(:connection).and_return(database)
  end

  it 'persists the data to sqlite' do
    updater.persist!
    expect(database.execute('select * from drives').length).to eq 1
  end

  it 'stores integers as integers' do
    updater.persist!
    row = database.execute('select * from drives').first
    expect(row[1]).to be_a Integer
  end

  it 'updates the record if it exists in the database' do
    updater.persist!
    drive.name = 'foobar'
    updater.persist!
    rows = database.execute('select * from drives')
    expect(rows.length).to eq 1
    expect(rows.first['name']).to eq 'foobar'
  end
end
