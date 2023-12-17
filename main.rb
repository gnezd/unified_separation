require 'pry'

def propagate(column)
  total = Array.new(column.size) {0.0}
  total[0] = column[0][0]
  (0..column.size-2).each do |i|
    total[i+1] = column[i][1]+column[i+1][0]
  end
  total.map{|sum| [sum/(1.0+$k), sum*$k/(1.0+$k)]}
end

column = Array.new(10) {[0.0, 0.0]}
$k = 0.25

binding.pry