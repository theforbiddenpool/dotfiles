#!/bin/bash

OPTION=$1
NUM=$2


function compare() {
  if [ $(echo "$1 $2 $3" | bc -l) -eq 1 ]; then
    echo 1
  else
    echo 0
  fi
}

function get_connected_screens() {
  SCREENS=($(xrandr --current | awk '/ connected/ { print $1 }'))
}

function get_actual_brightness() {
  xbacklight -get
}

function get_xrandr_brightness() {
  xrandr --verbose | awk '/Brightness/ { print $2; exit }'
}

function is_actual_brightness_at_minimum() {
  if [ $(compare $(get_actual_brightness) "<=" "2.0") -eq 1 ]; then
    echo 1
  else
    echo 0
  fi
}

function is_xrandr_brightness_at_minimum() {
  if [ $(compare $(get_xrandr_brightness) "<=" "0.25") -eq 1 ]; then
    echo 1
  else
    echo 0
  fi
}

function is_xrandr_brightness_at_maximum() {
  if [ $(compare $(get_xrandr_brightness) "==" "1.0") -eq 1 ]; then
    echo 1
  else
    echo 0
  fi
  
}

function increase_brightness() {
  if [[ $(is_xrandr_brightness_at_maximum) -eq 1 ]]; then
    xbacklight -inc $1 &
  else
    NEXT_VALUE=$(echo "$(get_xrandr_brightness) + 0.10" | bc -l)
    xrandr --output "${SCREENS[0]}" --brightness $NEXT_VALUE
  fi
}

function decrease_brightness() {
  if [[ $(is_actual_brightness_at_minimum) -eq 0 ]]; then
    xbacklight -dec $1 &
  else
    if [[ $(is_xrandr_brightness_at_minimum) -eq 0 ]]; then
      NEXT_VALUE=$(echo "$(get_xrandr_brightness) - 0.10" | bc -l)
      xrandr --output "${SCREENS[0]}" --brightness $NEXT_VALUE
    fi
  fi
}

get_connected_screens

if [[ $OPTION == 'inc' ]]; then
  increase_brightness $NUM
elif [[ $OPTION == 'dec' ]]; then
  decrease_brightness $NUM
elif [[ $OPTION == 'off' ]]; then
  xbacklight -set 0.0
else
  echo "unknown $OPTION option"
fi
