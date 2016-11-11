describe 'CollectionProxy' do

  let(:klass) { DriveConnect::Models::Director }
  let(:proxy) { DriveConnect::Models::CollectionProxy.new(klass, url: 'foo', klass: klass) }

  it 'has zero items when its created' do
    expect(proxy.length).to eq 0
  end

  it 'returns nil from an bracket index' do
    expect(proxy[0]).to eq nil
  end

  it 'can fetch an object from the store' do
    build(:director).save
    proxy.fetch!
    expect(proxy.length).to eq 1
  end

  it 'triggers an fetch event when completing the sync' do
    expect(proxy).to receive(:trigger).with(:fetch)
    proxy.fetch!
  end

  it 'accepts a klass option and creates new instances of the klass with it' do
    build(:director).save
    proxy.fetch!
    expect(proxy[0]).to be_a klass
  end

  it 'should be enumerable' do
    expect(proxy.map).to be_a Enumerable
  end
end
