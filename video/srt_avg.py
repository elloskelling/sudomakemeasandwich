#!/usr/bin/env python3
# 
# reads two SRT time stamps from STDIN and returns the average in ffmpeg format

import sys
import re

def main():
      try:
          t1=parse_time(input())
          t2=parse_time(input())
          build_time(0.5*(t1+t2))
      except:
          print("Error averaging timestamps")
          sys.exit(10)

def parse_time(time):
  hour, minute, second = time.split(':')
  hour, minute = int(hour), int(minute)
  second_parts = second.split(',')
  second = int(second_parts[0])
  millisecond = int(second_parts[1])
  return hour*3600+minute*60+second+millisecond/1000

def build_time(time):
  millisecond=1000*(time-int(time))
  time=int(time)
  hour=int(time/3600)
  time=time-hour*3600
  minute=int(time/60)
  second=time-minute*60
  print('%d:%d:%d.%d'%(hour,minute,second,millisecond))


if __name__ == '__main__':
  main()
