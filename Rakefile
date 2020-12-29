require "bundler/gem_tasks"

require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

task default: :test

GEMFILES = {
  '2.6@gem52' => 'Gemfile.rails52',
  '2.6@gem60' => 'Gemfile.rails60',
  '2.6@gem61' => 'Gemfile.rails61',
}

namespace :test do
  task :install_all do
    GEMFILES.each do |gemset, gemfile|
      puts "\n\n========== Running 'bundle install' with #{gemfile} ==========\n"
      puts `rvm #{gemset} --create do bundle install --gemfile=gemfiles/#{gemfile}`
    end
  end

  desc 'test against all supported versions of rails'
  task :all do
    err = 0
    cmd = ENV['RUN'] || 'rake test'
    GEMFILES.each do |gemset, gemfile|
      puts "\n\n========== Running '#{cmd}' with #{gemfile} ==========\n"
      puts `rvm #{gemset} do bundle exec --gemfile=gemfiles/#{gemfile} #{cmd}`
      err += 1 unless $?.success?
    end
    if err > 0
      puts "\n>>> #{err} gemfiles failed"
      exit err # exit code is # of failed runs
    end
  end
end
