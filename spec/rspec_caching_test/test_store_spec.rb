# coding: utf-8

require 'spec_helper'

describe ::RspecCachingTest::TestStore do
  describe '#initialize' do
    it { described_class.new.hit.should be_kind_of Hash }
  end

  let(:cache) { described_class.new }
  describe '#write' do
    before { cache.write('foo', 'bar') }
    it { cache.cached.should == %w(foo) }
    it { cache.data['foo'].value.should eq 'bar' }
  end

  describe '#read' do
    before {
      cache.write('foo', 'bar')
      cache.read('foo')
    }
    it { cache.readed.should == %w(foo) }
    it { cache.hit['foo'].should eq 1 }
    context 'more read' do
      before { cache.read('foo') }
      it { cache.readed.should == %w(foo foo) }
      it { cache.hit['foo'].should == 2 }
    end

    context 'no cached' do
      before { cache.read('bar') }
      it { cache.readed.should == %w(foo bar) }
      it { cache.hit['bar'].should be_nil }
    end
  end

  describe '#delete' do
    before {
      cache.write('foo', 'bar')
      cache.delete('foo').should be_true
    }
    it { cache.expired.should === %w(foo) }
  end
end