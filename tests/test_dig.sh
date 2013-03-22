#!/usr/bin/env roundup

describe "dig"

it_does_nothing_with_no_argument() {
  result=$(bash dig.sh)
  [[ "$result" =~ uid=.dig_keep_typing ]]
}

it_does_nothing_with_blank_argument() {
  result=$(bash dig.sh '')
  [[ "$result" =~ uid=.dig_keep_typing ]]
}

it_does_nothing_with_single_word() {
  result=$(bash dig.sh 'pjkh')
  [[ "$result" =~ uid=.dig_keep_typing ]]
}

it_does_nothing_with_invalid_type() {
  result=$(bash dig.sh 'pjkh.com foo')
  [[ "$result" =~ uid=.dig_keep_typing ]]
}

it_queries_if_ends_with_space() {
  result=$(bash dig.sh 'pjkh.com ')
  [[ "$result" =~ uid=.dig_answer ]]
}

it_queries_if_ends_with_valid_type() {
  result=$(bash dig.sh 'pjkh.com mx')
  [[ "$result" =~ uid=.dig_answer ]]
}

it_notifies_about_no_results() {
  result=$(bash dig.sh 'nonexistent.pjkh.com a')
  [[ "$result" =~ uid=.dig_no_results ]]
}

it_reverse_lookups_ipv4_address() {
  result=$(bash dig.sh '127.0.0.1 ')
  [[ "$result" =~ uid=.dig_answer ]]
  [[ "$result" =~ ptr.png ]]
  [[ "$result" =~ title.localhost ]]
}

it_reverse_lookups_ipv6_address() {
  result=$(bash dig.sh '::1 ')
  [[ "$result" =~ uid=.dig_answer ]]
  [[ "$result" =~ ptr.png ]]
  [[ "$result" =~ title.localhost ]]
}

it_strips_priority_from_mx_records() {
  result=$(bash dig.sh 'pjkh.com mx')
  [[ "$result" =~ uid=.dig_answer ]]
  [[ "$result" =~ arg=\'mx2.emailsrvr.com\' ]]
  [[ "$result" =~ title.10\ mx2.emailsrvr.com ]]
}

