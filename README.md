# rspec_caching_test

this is copy project

https://github.com/econsultancy/rspec-caching-test-plugin/blob/econsultancy-2011-08-05

## Insatall

In your Gemfile:

```ruby
gem 'rspec_caching_test', require: 'false', git: 'git://github.com/kengos/rspec_caching_test.git'
```  

In your spec_helper.rb:

```ruby
require 'rspec_caching_test'
RspecCachingTest::CacheTest.setup
```

with Spork:

```ruby
Spork.prefork do
  # something
		
  require 'rspec_caching_test'
  RspecCachingTest::CacheTest.setup
		
  RSpec.configure do |config|
    # something
  end
end

Spork.each_run do
  # something
end
```  


## Usage:

### if you use caches_page

Controller:  

```ruby
class ProductsController < ActionController::Base
  caches_page :index  
 
  def index
    # something
  end
end
```

RSpec:

```ruby
describe "get 'index'" do
  it "should cache the page" do
    lambda { get :index }.should cache_page('/products') # this is page url
  end
end
```

### if you use caches_action

**Maybe contains bugs**

Controller:  

```ruby
class ProductsController < ActionController::Base
  caches_action :index
  
  def index
    # something
  end
end
```

RSpec:

```ruby
describe "get 'index'" do
  it "should cache the action" do
    lambda { get :index }.should cache_action(:index)
  end
end
```

### if you use fragment

View:  

```erb
<%= cache 'my_cache' do %>
  <p>my_cache</p>
<% end %>
```

RSpec:  

```ruby
describe "get 'index'" do
  it "should fragment cache" do
    lambda { get :index }.should cache_fragment('views/my_cache')
  end
end
```

## More

use subject:

```ruby
before { get :index }
subject { controller.cache_store.cached }
it { should have(3).items }
it { should be_include([xxxx, yyyy, zzzz]) }
```
cache_store:

```ruby
before { get :index }
it { controller.cache_store.should be_kind_of RspecCachingTest::CacheTest::TestStore }
```