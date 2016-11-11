require 'spec_helper'

describe DriveConnect::Presenters::Base do
  it 'will delegate to the model object' do
    model = OpenStruct.new(bar: 'bar')
    presenter = TestPresenter.new(model)
    expect(presenter.model_attribute(:bar)).to eq 'bar'
  end

  it 'will call the method on the presenter if it exists there' do
    model = OpenStruct.new(foo: 'bar')
    presenter = TestPresenter.new(model)
    expect(presenter.model_attribute(:foo)).to eq 'baz'
  end

  it 'will delegate methods' do
    presenter = TestPresenter.new DelegateTestPresenter.new
    expect(presenter.test_method).to eq 'test method return'
  end
end

class TestPresenter < DriveConnect::Presenters::Base
  def foo
    'baz'
  end
end

class DelegateTestPresenter
  def test_method
    'test method return'
  end
end
