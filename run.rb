#!/usr/bin/env ruby
require 'httparty'
require 'json'
raise "Add a submission to the submission directory to start" if Dir['submission/*'].count == 0

`docker build -t runner .`

PATH          = `pwd`.strip

# CircleCI + Github <3
GITHUB_TOKEN  = ENV['GITHUB_TOKEN']
GITHUB_PR_NUM = ENV.fetch('CI_PULL_REQUEST', '').split('/').last
GITHUB_REPO   = "#{ENV['CIRCLE_PROJECT_USERNAME']}/#{ENV['CIRCLE_PROJECT_REPONAME']}"

PROBLEM       = ENV.fetch('PROBLEM')
SUBMISSION    = Dir['submission/*'].first.split('/').last.gsub(/[^a-zA-Z0-9.]/, '')
N_BYTES       = File.read("submission/#{SUBMISSION}").length
CHOSEN_DATA   = Dir["problems/#{PROBLEM}/*"].sample.split('/').last.split('.').first
LANG          = SUBMISSION.split('.').last.downcase.gsub(/[^a-z]/, '')
puts "#{LANG}: #{N_BYTES} byte(s)"

COMMAND    = { 'py' => 'python3', 'js' => 'node', 'rb' => 'ruby', 'sh' => 'bash', 'c' => 'run_c' }.fetch(LANG)
OUTPUT     = `docker run --net=none -v #{PATH}/submission:/code -i runner #{COMMAND} /code/#{SUBMISSION} < problems/#{PROBLEM}/#{CHOSEN_DATA}.in`.strip
EXPECTED   = File.read("problems/#{PROBLEM}/#{CHOSEN_DATA}.out").strip


if GITHUB_TOKEN
  if OUTPUT == EXPECTED
    HTTParty.put("https://#{GITHUB_TOKEN}@api.github.com/repos/#{GITHUB_REPO}/issues/#{GITHUB_PR_NUM}/labels", { body: [PROBLEM, LANG, N_BYTES.to_s].to_json })
  else
    HTTParty.put("https://#{GITHUB_TOKEN}@api.github.com/repos/#{GITHUB_REPO}/issues/#{GITHUB_PR_NUM}/labels", { body: [PROBLEM, 'ERROR'].to_json })
  end
else
  if OUTPUT == EXPECTED
    puts "Correct!"
  else
    puts "Wrong! Try again."
    puts "Output:\n#{OUTPUT}"
    puts "Expected:\n#{EXPECTED}"
  end
end
