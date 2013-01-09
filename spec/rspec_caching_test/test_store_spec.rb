# coding: utf-8

require 'spec_helper'

describe RspecCachingTest::TestStore do
  describe '#initialize' do
    it { describe_class.new.hit be_kind_of Hash }
  end
end