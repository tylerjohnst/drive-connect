describe 'Schema' do
  let(:database) { DriveConnect::Store::Database.new }
  let(:path)     { "tmp/test.sqlite3" }

  it 'can create an empty database' do
    database
    expect(File.exists? path).to be true
  end

  it 'it will not run the load_schema if tables exist' do
    database.load_schema!
    expect(database.number_of_tables).to eq 4
  end

  it 'can set the database path' do
    expect(DriveConnect::Store::Database.path_to_database).to eq path
  end
end
