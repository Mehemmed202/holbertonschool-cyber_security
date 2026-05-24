#!/usr/bin/env ruby

require 'optparse'

TASKS_FILE = 'tasks.txt'

def load_tasks
  File.exist?(TASKS_FILE) ? File.readlines(TASKS_FILE, chomp: true) : []
end

def save_tasks(tasks)
  File.write(TASKS_FILE, tasks.join("\n"))
end

options = {}

OptionParser.new do |opts|
  opts.banner = "Usage: cli.rb [options]"

  opts.on('-a', '--add TASK', 'Add a new task') do |task|
    options[:add] = task
  end

  opts.on('-l', '--list', 'List all tasks') do
    options[:list] = true
  end

  opts.on('-r', '--remove INDEX', 'Remove a task by index') do |index|
    options[:remove] = index.to_i
  end

  opts.on('-h', '--help', 'Show help') do
    puts opts
    exit
  end
end.parse!

tasks = load_tasks

if options[:add]
  tasks << options[:add]
  save_tasks(tasks)
  puts "Task '#{options[:add]}' added."
end

if options[:list]
  tasks.each_with_index do |task, index|
    puts "#{index + 1}. #{task}"
  end
end

if options[:remove]
  removed_task = tasks.delete_at(options[:remove] - 1)

  if removed_task
    save_tasks(tasks)
    puts "Task '#{removed_task}' removed."
  else
    puts "Invalid task index."
  end
end
