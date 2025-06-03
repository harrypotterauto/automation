#!/bin/bash

while true; do
  xdotool mousemove_relative 1 0
  sleep 30
  xdotool mousemove_relative -- -1 0
  sleep 30
done
