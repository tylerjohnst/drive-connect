require 'spec_helper'

describe DriveConnect::Presenters::Director do
  let(:director)  { build(:director) }
  let(:presenter) { DriveConnect::Presenters::Director.new(director) }
end
