require 'pry'

def propagate(column, k)
  total = Array.new(column.size) {0.0}
  total[0] = column[0][0]
  (0..column.size-2).each do |i|
    total[i+1] = column[i][1]+column[i+1][0]
  end
  total.map{|sum| [sum/(1.0+k), sum*k/(1.0+k)]}
end

column = Array.new(1000) {[0.0, 0.0]}
column2 = Array.new(1000) {[0.0, 0.0]}
k1 = 0.1
k2 = 0.12
column[1]=[800.0, 200.0]
column2[1]=[800.0, 200.0]
profile_data = File.open 'prof.dat','w'
chromatogram_data = File.open 'chrom.dat','w'

ready1=0
ready2=0

while ready1 + ready2 < 4
  #system('clear')
  #puts '-'*10
  #puts (0..column.size-1).map{|i| "#{column[i].join(' ')} | #{column2[i].join(' ')}"}
  #puts '-'*10
  column = propagate(column, k1)
  column2 = propagate(column2, k2)
  #gets
  chromatogram_data.puts column[-1].sum+column2[-1].sum
  ready1 = 1 if column[-1][0] > 0.01
  ready2 = 1 if column2[-1][0] > 0.01
  ready1 = 2 if (column[-1][0] - column[-2][0] > 0) && column[-1][0] < 0.1
  ready2 = 2 if (column2[-1][0] - column2[-2][0] > 0) && column2[-1][0] < 0.1
end
profile_data.close
chromatogram_data.close

binding.pry