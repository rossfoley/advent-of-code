#!/usr/bin/ruby

require 'set'
seen = Set.new

def f a;
    a |= 0x10000
    b = 8595037
    b += a&0xff;       b &= 0xffffff
    b *= 65899;        b &= 0xffffff
    b += (a>>8)&0xff;  b &= 0xffffff
    b *= 65899;        b &= 0xffffff
    b += (a>>16)&0xff; b &= 0xffffff
    b *= 65899;        b &= 0xffffff
    b
end

n = f 0
loop {
    n2 = f n
    abort "#{n}" if seen.include? n2
    seen.add n
    n = n2
}
