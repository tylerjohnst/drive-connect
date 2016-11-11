describe 'DriveStatus' do
  let(:json) { JSON.parse File.read('spec/fixtures/drive_status.json') }
  let(:presenter) { DriveConnect::Presenters::DriveStatus.new(json) }

  it 'knows if the payload is present' do
    expect(presenter.has_payload?).to eq true
  end

  it 'knows if the payload is empty' do
    presenter = DriveConnect::Presenters::DriveStatus.new({})
    expect(presenter.has_payload?).to eq false
  end

  it 'knows if theres an error key that the status is empty' do
    presenter = DriveConnect::Presenters::DriveStatus.new({"Error"=>"signal: segmentation fault"})
    expect(presenter.has_payload?).to eq false
  end

  it 'has the heatsink tempature' do
    expect(presenter.heatsink_temperature).to eq '27°C'
  end

  context 'motor status' do
    it 'has the motor voltage' do
      expect(presenter.motor_voltage).to eq '147.6V'
    end

    it 'reads the motor frequency' do
      expect(presenter.motor_frequency).to eq '406Hz'
    end

    it 'can fetch the current RPM' do
      expect(presenter.motor_speed).to eq '2435 RPM'
    end
  end

  context 'payback' do
    it 'formats the power reference as a percentage' do
      expect(presenter.power_reference).to eq '100%'
    end

    it 'formats the energy cost as kWh' do
      expect(presenter.energy_cost).to eq '$0.17/kWh'
    end

    it 'formats the investment as dollars' do
      expect(presenter.investment).to eq '$10,000'
    end

    it 'formats the energy savings as kWh' do
      expect(presenter.energy_savings).to eq '29,047 kWh'
    end

    it 'displays a comma delimited human readable number for hours' do
      expect(presenter.operating_hours).to eq '5,664 Hours'
    end

    it 'renders a human readable running hours' do
      expect(presenter.running_hours).to eq '4,907 Hours'
    end

    it 'renders the number of starts' do
      expect(presenter.number_of_starts).to eq '194 Starts'
    end
  end
end
