# Defines a command class to interact with the history profiler.

# Represents a single command with count of how many times
# it appeared.
class Command
  # Class-general attributes
  @@total  = 0
  @@unique = 0

  include Comparable
  attr_reader :text, :count

  def initialize(text)
    @text  = text
    @count = 1
    @@unique += 1
    @@total  += 1
  end

  # Allows us to compare this class to one another.
  # (operators: >, <, ==, <=, >=)
  def <=>(other)
    @count <=> other.count
  end

  def add
    @count  += 1
    @@total += 1
  end

  def to_s
    "#{@text}: #{@count}"
  end

  def Command.total
    @@total
  end

  def Command.unique
    @@unique
  end

end

# # Sandboxing ensues
# begin
#   var = Command.new 'ls'
#   var.add

#   puts var

#   var2 = Command.new 'mv'
#   var2.add
#   var2.add
#   var.add

#   puts var > var2
#   puts var.to_s
#   puts Command.total
#   puts Command.unique
# end


