require 'rubygems'

#RSpec::Matchers.define :my_matcher do |expected|
#  match do |actual|
#    true
#  end
#end

def time_format(time)
  time.strftime('%Y/%m/%d %H:%M:%S')
end
