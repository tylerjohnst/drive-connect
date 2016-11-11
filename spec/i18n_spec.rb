describe 'I18n' do
  it 'appends the translation file to the load path' do
    expect(I18n.t 'drives.labels.name').to eq 'Name'
  end
end
