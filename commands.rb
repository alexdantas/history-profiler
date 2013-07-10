require_relative 'command'

# The logic of parsing all commands.
#
# It reads the history file and stores the results inside an
# array of *Command*.
#
class Commands
  # Array of *Command* containing all commands read from the file.
  attr_reader :all

  def initialize(filepath)
    @filepath = filepath
    @all = []
    @blank = Command.new("(blank)")
  end

  # Parses the file storing all data in memory.
  def parse
    @file = File.open(@filepath)

    @file.each do |line|
      # Get first word
      # (returns whole word if is the only one on the line)
      current = line.partition(' ')[0].chomp

      if current == "sudo"
        current = line.partition(' ')[1].chomp # get second word
      end

      if current == "" or current =~ /^\s.*$/ # purely blank lines
        @blank.add
        next
      end

      # Will look into our "command database" and
      # add one count if found.
      found = false
      @all.each do |command|
        if command.text == current
          command.add
          found = true
          break
        end
      end

      # Or will add current command if not found.
      if not found
        command = Command.new(current)
        @all.push command
      end
    end

    all.sort! # Will sort in ascending order
  end

  # Total number of commands
  def total
    Command.total
  end

  # Ammount of unique commands.
  def unique
    Command.unique
  end

  def blank
    @blank.count
  end
end

