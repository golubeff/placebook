require 'spec_helper'

describe Placebook::Client do
  describe '.new' do
    it 'should have accessors for its initializers' do
      client = Placebook::Client.new('abc', 'def', 'hgi')
      client.app_id.should == 'abc'
      client.app_secret.should == 'def'
      client.access_token.should == 'hgi'
    end
  end

  context 'initialized' do
    subject{ Placebook::Client.new('abc', 'def', 'hgi')}

    before do
      subject.client.connection.build do |c|
        c.adapter :test do |stub|
          stub.get('/123?access_token=hgi'){ [200, {'Content-Type' => 'application/json'}, checkin_json(:id => '123')] }
          stub.get('/someone/checkins?access_token=hgi'){ [200, {'Content-Type' => 'application/json'}, MultiJson.encode(10.times.map{ checkin_hash }) ] }
          stub.get('/search?type=checkin&q=hello&access_token=hgi'){ [200, {'Content-Type' => 'application/json'}, MultiJson.encode(10.times.map{ checkin_hash }) ] }
        end
      end
    end
  
    describe '#checkin' do
      it 'should be a single checkin' do
        subject.checkin('123').should be_kind_of(Placebook::Checkin)
      end
    
      it 'should have the returned attributes' do
        subject.checkin('123').id.should == '123'
      end
    end
  
    describe '#checkins_for' do
      it 'should be a list of checkins' do
        ins = subject.checkins_for('someone')
        ins.should be_kind_of(Array)
        ins.reject{|i| i.kind_of?(Placebook::Checkin)}.should be_empty
      end
    end
  
    describe '#search' do
      it 'should be a list of checkins' do
        ins = subject.search('hello')
        ins.should be_kind_of(Array)
        ins.reject{|i| i.kind_of?(Placebook::Checkin)}.should be_empty
      end
    end
  end
end