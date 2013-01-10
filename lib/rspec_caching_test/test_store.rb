# coding: utf-8

module RspecCachingTest
  class TestStore < ::ActiveSupport::Cache::Store
    # Record of what the app tells us to cache
    attr_accessor :cached
      
    # Record of what the app tells us to expire
    attr_accessor :expired

    # Record of what the app tells us to expire via patterns
    attr_accessor :expiration_patterns
      
    # Cached data that could be returned
    attr_accessor :data

    # Setting to enable the returning of cached data.
    attr_accessor :read_cache

    attr_accessor :readed
    attr_accessor :hit

    def initialize(do_read_cache = false)
      @read_cache = do_read_cache
      clear
      super
    end

    def delete_matched(matcher, options = nil)
      matcher = key_matcher(matcher, options)
      @data.keys.each do |key|
        delete_entry(key, options) if key.match(matcher)
      end
      @expiration_patterns << matcher
    end

    def increment(name, amount = 1, options = nil)
      if num = read(name, options)
        num = num.to_i + amount
        write(name, num, options)
        num
      else
        nil
      end
    end

    def decrement(name, amount = 1, options = nil)
      if num = read(name, options)
        num = num.to_i - amount
        write(name, num, options)
        num
      else
        nil
      end
    end

    def cleanup(options = nil)
      @data.keys.each do |key|
        entry = @data[key]
        delete_entry(key, options) if entry && entry.expired?
      end
    end

    def clear(options = nil)
      @data = {}
      @readed = []
      @cached = []
      @expired = []
      @expiration_patterns = []
      @hit = {}
    end

  protected
    def read_entry(key, options)
      entry = @data[key]
      @readed << key
      @hit[key] = @hit[key] ? @hit[key] + 1 : 1 if entry
      @read_cache ? entry : nil
    end

    def write_entry(key, entry, options)
      @data[key] = entry
      @cached << key
      true
    end

    def delete_entry(key, options)
      entry = @data.delete(key)
      @expired << key
      !!entry
    end
  end
end