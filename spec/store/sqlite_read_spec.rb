describe 'SQLite::Read' do

  let(:drive)    { build :drive }
  let(:database) { DriveConnect::Store::Database.new(':memory:') }
  let(:sql)      { DriveConnect::Store::SQLBuilder.new(drive.class.resource_name).select('*') }
  let(:reader)   { DriveConnect::Store::SQLite::Read.new(drive.class, sql.to_sql) }
  let(:writer)   { DriveConnect::Store::SQLite::Write.new(drive) }

  before(:each) do
    allow(writer).to receive(:connection).and_return(database)
    allow(reader).to receive(:connection).and_return(database)
    writer.persist!
  end

  it 'fetches the results from the database' do
    expect(reader.rows.length).to eq 1
  end

  it 'returns an array of hashes' do
    expect(reader.rows.first).to be_a drive.class
  end

  it 'unmarshalls the values to a hash' do
    expect(reader.rows.first.id).to eq 2
  end
end
