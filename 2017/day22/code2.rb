g=$<.map &:chomp
g.map!{|x|t=?.*1000
t+x+t}
t=Array.new(1000){?.*g[0].size}
g=t+g+t
p x=g[0].size/2
p y=g.size/2
#g[y][x]=?!
d=:u
tc=->{d=case d
when :u then :l
when :l then :d
when :d then :r
when :r then :u
end}
ti=->{d=case d
when :u then :r
when :l then :u
when :d then :l
when :r then :d
end}
tf=->{d=case d
when :u then :d
when :l then :r
when :d then :u
when :r then :l
end}
yy=0
10_000_000.times{tt=g[y][x]
g[y][x]=case tt
when ?#
ti[]
?F
when ?W
yy+=1
?#
when ?F
tf[]
?.
when ?.
tc[]
?W
end
case d
when :u then y-=1
when :l then x-=1
when :d then y+=1
when :r then x+=1
end
}
puts yy
