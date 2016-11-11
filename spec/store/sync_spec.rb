describe 'Sync' do
  let(:klass)    { DriveConnect::Models::Director }
  let(:sync)     { DriveConnect::Store::Sync.new(klass) }

  before(:each) do
    sync.class.http_adapter = FakeAPIHTTPAdapter
    allow(FakeAPIHTTPAdapter).to receive(:request!).with(:post, 'bulk/directors', Hash).and_yield [load_fixture('director')], nil
  end

  it 'accepts a klass' do
    expect(sync.resource_name).to eq klass.resource_name
  end

  it 'can find all modified directors' do
    build(:director).update_attributes(name: 'foobar')
    build(:director, id: 1).save
    expect(sync.dirty_records.length).to eq 1
  end

  it 'set the HTTP adapter' do
    expect(sync.class.http_adapter).to eq FakeAPIHTTPAdapter
  end

  it 'takes the results of the request and inserts them in to the database' do
    sync.sync!
    sql = DriveConnect::Store::SQLBuilder.new(klass.resource_name).select('*')
    expect(DriveConnect::Store::SQLite::Read.new(klass, sql.to_sql).rows.length).to eq 1
  end

  it 'can run multiple times and delete the previous records' do
    sync.sync!
    sync.sync!
    sql = DriveConnect::Store::SQLBuilder.new(klass.resource_name).select('*')
    expect(DriveConnect::Store::SQLite::Read.new(klass, sql.to_sql).rows.length).to eq 1
  end
end
