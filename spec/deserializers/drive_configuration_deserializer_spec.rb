describe 'DriveConfiguration Deserializer' do

  let(:drive)   { build(:drive) }
  let(:actions) { build_collection(:action) }
  let(:payload) { JSON.parse(File.read 'spec/fixtures/drive_run_config.json') }
  let(:deserializer) { DriveConnect::Deserializers::DriveConfiguration.new(drive, actions, payload) }
  let(:attributes) { deserializer.attributes }


  it 'can abstract the timed actions' do
    expect(attributes).to have_key :actions_attributes
  end

  it 'should have 10 actions' do
    expect(attributes[:actions_attributes].length).to eq 8
  end

  it 'has the low value' do
    expect(attributes[:low_motor_speed]).to eq 5
  end


  it 'has the high value' do
    expect(attributes[:high_motor_speed]).to eq 3450
  end

  context 'action' do
    let(:action) { attributes[:actions_attributes]['0'] }

    it 'has the id attribute of the action' do
      expect(action['id']).to eq actions.first.id
    end

    it 'has the on time' do
      expect(action['on_time']).to eq 5400
    end

    it 'has the on action index' do
      expect(action['on_action']).to eq 2
    end

    it 'has the occurrence' do
      expect(action['occurrence']).to eq 3
    end

    it 'has the off time' do
      expect(action['off_time']).to eq 66600
    end

    it 'has an off action' do
      expect(action['off_action']).to eq 3
    end
  end
end
