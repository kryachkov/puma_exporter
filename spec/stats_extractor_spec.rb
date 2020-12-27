require 'json'
require '../stats_extractor'

single_worker = JSON.parse(File.read('single_worker.json'))
multiple_workers = JSON.parse(File.read('multiple_workers.json'))

puts StatsExtractor.new(single_worker).perform.inspect
puts StatsExtractor.new(multiple_workers).perform.inspect
