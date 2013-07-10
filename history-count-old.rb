#!/usr/bin/env ruby
# Print statistics about your history file.
#
# Will show most-used commands, percentages, etc.

# For printing stuff on the terminal with colors
require 'term/ansicolor'

# History file path
#file = File.open("/home/kure/.bash_history")
file = File.open("/tmp/history")

# Each element contains a command (string) and a counter (int)
# telling how many times that command has appeared on the
# history file.
#
# $commands[0] first command ---> [0][0] first command name
#                                 [0][1] first command count
$commands = []
$total = 0

file.each do |line|

  # Get first word
  # (returns whole word if is the only one on the line)
  current = line.partition(' ')[0].chomp

  if current == "sudo"
    current = line.partition(' ')[1].chomp # get second word
  end

  # Will look into our "command database" and
  # add one count if found.
  found = false
  $commands.each do |command|

    if command[0] == current
      command[1] += 1
      found = true
      break
    end
  end

  # Or will add current command if not found.
  if not found
    command = []
    command[0] = current
    command[1] = 1

    $commands.push command
  end

  $total += 1
end

# Now I'll print the results.
# Here's some nice colors for ya:
y = Term::ANSIColor::yellow
r = Term::ANSIColor::red
b = Term::ANSIColor::blue
w = Term::ANSIColor::white
g = Term::ANSIColor::green
m = Term::ANSIColor::magenta
c = Term::ANSIColor::cyan
B = Term::ANSIColor::bold
R = Term::ANSIColor::reset

puts "#{B}#{r}Command history profiler#{R}"
puts "Total history lines:   #{c}#{$total}#{R}"
puts "Total unique commands: #{B}#{c}#{$commands.size}#{R}"
puts

def percentage(what, total)
  perc = what/(1.0 * total)
  return (perc * 100).round(2)
end

$commands.each do |command|
  if command[1] > 1
    perc = percentage(command[1], $total)
    str = "#{g}#{command[0]}#{R}: #{y}#{command[1]}#{R} (#{B}#{m}#{perc}%#{R})"
    puts str
  end
end


