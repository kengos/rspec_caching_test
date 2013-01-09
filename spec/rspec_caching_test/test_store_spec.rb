# coding: utf-8

require 'spec_helper'

describe ::RspecCachingTest::TestStore do
  describe '#initialize' do
    it { described_class.new.hit.should be_kind_of Hash }
  end
end