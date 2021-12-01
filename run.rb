# frozen_string_literal: true

require 'require_all'
require 'pry'
require_all 'lib'
require_all 'tasks'

day = ENV['TASK_DAY']

print 'Task 1 Result - ', Module.const_get("Tasks::Day#{day}::Run").new.call1
puts ''
print 'Task 2 Result - ', Module.const_get("Tasks::Day#{day}::Run").new.call2
puts ''
