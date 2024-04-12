#!/usr/bin/env zsh

# Required for shunit2 to run correctly
setopt shwordsplit
SHUNIT_PARENT=$0

# ------------------------------------------------------------------------------
# SHUNIT2 HOOKS
# ------------------------------------------------------------------------------

oneTimeSetUp() {
  export TERM="xterm-256color"

  SPACESHIP_PROMPT_FIRST_PREFIX_SHOW=true
  SPACESHIP_PROMPT_ADD_NEWLINE=false
  SPACESHIP_PROMPT_ORDER=(char)

  source "spaceship.zsh"
}

setUp() {
  SPACESHIP_CHAR_PREFIX=""
  SPACESHIP_CHAR_SUFFIX=""
  SPACESHIP_CHAR_SYMBOL="➜ "
  SPACESHIP_CHAR_SYMBOL_SUCCESS="${SPACESHIP_CHAR_SYMBOL}"
  SPACESHIP_CHAR_SYMBOL_FAILURE="${SPACESHIP_CHAR_SYMBOL}"
  SPACESHIP_CHAR_COLOR_SUCCESS="green"
  SPACESHIP_CHAR_COLOR_FAILURE="red"
  SPACESHIP_CHAR_COLOR_SECONDARY="yellow"
}

oneTimeTearDown() {
  unset SPACESHIP_PROMPT_FIRST_PREFIX_SHOW
  unset SPACESHIP_PROMPT_ADD_NEWLINE
  unset SPACESHIP_PROMPT_ORDER
}

tearDown() {
  unset SPACESHIP_CHAR_PREFIX
  unset SPACESHIP_CHAR_SUFFIX
  unset SPACESHIP_CHAR_SYMBOL
  unset SPACESHIP_CHAR_COLOR_SUCCESS
  unset SPACESHIP_CHAR_COLOR_FAILURE
  unset SPACESHIP_CHAR_COLOR_SECONDARY
}

# ------------------------------------------------------------------------------
# TEST CASES
# ------------------------------------------------------------------------------

test_char() {
  SPACESHIP_CHAR_COLOR_SUCCESS=blue
  SPACESHIP_CHAR_SYMBOL_SUCCESS="S "

  local expected="%{%B%F{$SPACESHIP_CHAR_COLOR_SUCCESS}%}$SPACESHIP_CHAR_SYMBOL_SUCCESS%{%b%f%}"
  local actual="$(spaceship::testkit::render_prompt)"

  assertEquals "render char" "$expected" "$actual"
}

test_char_failure() {
  SPACESHIP_CHAR_COLOR_FAILURE=yellow
  SPACESHIP_CHAR_SYMBOL_FAILURE="F "

  local expected="%{%B%F{$SPACESHIP_CHAR_COLOR_FAILURE}%}$SPACESHIP_CHAR_SYMBOL_FAILURE%{%b%f%}"
  command false # this command should exit with non-zero code
  local actual="$(spaceship::testkit::render_prompt)"

  assertEquals "render char with failure" "$expected" "$actual"
}

test_char_prefix() {
  SPACESHIP_CHAR_PREFIX='prefix'
  SPACESHIP_CHAR_SUFFIX=''

  local expected="%{%B%}$SPACESHIP_CHAR_PREFIX%{%b%}%{%B%F{green}%}➜ %{%b%f%}"
  local actual="$(spaceship::testkit::render_prompt)"

  assertEquals "render char with prefix" "$expected" "$actual"
}

test_char_suffix() {
  SPACESHIP_CHAR_PREFIX=''
  SPACESHIP_CHAR_SUFFIX='suffix'

  local expected="%{%B%F{green}%}➜ %{%b%f%}%{%B%}$SPACESHIP_CHAR_SUFFIX%{%b%}"
  local actual="$(spaceship::testkit::render_prompt)"

  assertEquals "render char with suffix" "$expected" "$actual"
}

# ------------------------------------------------------------------------------
# SHUNIT2
# Run tests with shunit2
# ------------------------------------------------------------------------------

source tests/shunit2/shunit2
