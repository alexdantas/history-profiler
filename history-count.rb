#!/usr/bin/env ruby
# Print statistics about your history file.
#
# Will show most-used commands, percentages, etc.

require_relative 'commands' # Our main parser class.
require 'term/ansicolor'    # For printing stuff on the
# terminal with colors.

# Here we go!
begin

  commands = Commands.new("#{Dir.home}/.bash_history")
  commands.parse

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

  puts "Total history lines:   #{c}#{commands.total}#{R}"
  puts "Total unique commands: #{B}#{c}#{commands.unique}#{R}"
  puts

  def percentage(what, total)
    perc = what/(1.0 * total)
    return (perc * 100).round(2)
  end

  # Will print the top 10 most used commands
  top = 15

  commands.all.reverse.first(top).each do |command|
    if command.count > 1
      perc = percentage(command.count, Command.total)
      str = "#{g}#{command.text}#{R}:\t#{y}#{command.count}#{R} (#{B}#{m}#{perc}%#{R})"
      puts str
    end
  end

  count = 0
  commands.all.reverse.last(commands.all.reverse.size - top).each do |command|
    count += command.count
  end
  perc = percentage(count, commands.total)

  puts "#{g}Other#{R}:\t#{y}#{count}#{R} (#{B}#{m}#{perc}%#{R})"

  puts
  puts "Total blank lines: #{commands.blank}"
end

