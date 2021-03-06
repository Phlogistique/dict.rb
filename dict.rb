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
  exp.to_s.gsub(/<(.+?)>/) do $~
    r = _R($~[1]).map{|i|i[0]}.join
    "[#{r}]"
  end
end
def E exp; search(edict, exp) end
def K exp; search(kanjidic, exp) end
def F exp; E /^#{exp} |\[#{exp}\]/; end
def B exp; E /^#{exp}|\[#{exp}/; end
def _R *kanji
  kradfile.select { |j| kanji.join.split('').map { |i| j[i] }.all? }
end
def R *kanji; _R(*kanji).each{|i|print i}; end
def D kanji; kradfile.each{|i| print i if i =~ /^#{kanji}/}; end

send(*([File.basename($0)] + ARGV))

