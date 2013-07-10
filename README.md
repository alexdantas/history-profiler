# history profiler

Parses user's bash history file (`~/.bash_history`) and gives interesting
statistics about command usage and frequency.

## Usage

`$ ruby history-count.rb`

## Note

This is still on development, if you want to use another history file,
change it on `history-count.rb`.


## For developers

It parses line by line, getting the first word and counting it's frequency.
If it's `sudo`, it gets the second word.

It something's messed up, it counts as `blank lines`.

