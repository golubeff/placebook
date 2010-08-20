require 'spec_helper'

describe Placebook::Checkin do
  subject{ Placebook::Checkin.new(checkin_hash) }

  it 'should convert the appropriate subhashes' do
    subject.from.should be_kind_of(Placebook::User)
    subject.place.should be_kind_of(Placebook::Place)
    subject.place.location.should be_kind_of(Placebook::Location)
  end
end