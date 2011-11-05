#!/usr/bin/env ruby1.9.1
#encoding: utf-8
#
# Copyright 2011 Noé Rubinstein
#
# This program is free software. It comes without any warranty, to the extent
# permitted by applicable law. You can redistribute it and/or modify it under
# the terms of the Do What The Fuck You Want To Public License, Version 2, as
# published by Sam Hocevar. See http://sam.zoy.org/wtfpl/COPYING for more
# details.

$dict_dir = File.join ENV["HOME"], "jp"

def dict f
  $dict ||= {}
  $dict[f] ||= File.readlines(File.join($dict_dir,f))
end
def edict; dict 'edict'; end
def kanjidic; dict 'kanjidic'; end
def kradfile; dict 'kradfile'; end
def search(dic, exp)
  r = Regexp.new(transform(exp))
  dic.each{|i|print i if i =~ r}
end
def transform exp
  exp.to_s.gsub(/<(.+?)>/) do |r| 
    r = r[1..-2] # remove <>; ugly because gsub can't yield a Match object
    r = _R(r).map{|i|i[0]}.join
    "[#{r}]"
  end
end
def E exp; search(edict, exp) end
def K exp; search(kanjidic, exp) end
def F exp; E /^#{exp} |\[#{exp}\]/; end
def B exp; E /^#{exp}|\[#{exp}/; end
def _R *kanji
  results = kradfile.clone
  kanji.join.split('').each do |i|
    results.select! do |j|
      j =~ /#{i}/
    end
  end
  results
end
def R *kanji; _R(*kanji).each{|i|print i}; end

send(*([File.basename($0)] + ARGV))

