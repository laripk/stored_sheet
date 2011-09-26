require 'sinatra'
require 'mongoid'


class Sheet
   include Mongoid::Document
   include Mongoid::Timestamps
   
   field :sheet_name
   embeds_many :columns
   embeds_many :rows
   
end

class Column
   include Mongoid::Document
   embedded_in :sheet
   
   field :num, type: Integer
   field :name, type: String
   field :width, type: Integer, default: 100
   
   def self.add_cols(col_array, number_to_add)
      arr_leng = col_array.length
      number_to_add.to_i.times do |i|
         n = arr_leng + i + 1
         col = Column.new( num: n, name: col_name(n) )
         col_array << col
      end
      col_array
   end
   
   def self.col_name(col_num)
      name = ""
      num = col_num.to_i
      raise ArgumentError, "col_num cannot be less than 1" if num < 1
      while true do
         num -= 1
         n = num % 26
         letter = ("A".ord + n).chr
         name = "#{letter}#{name}"
         break if num < 26
         num = (num - n) / 26
      end 
      name
   end
   # 1  => A
      # 1 - 1 = 0, % 26 = 0, + A = A
   # 2  => B
      # 2 - 1 = 1, % 26 = 1, + A = B
   # 26 => Z
      # 26 - 1 = 25, % 26 = 25, + A = Z
   # 27 => AA
      # 27 - 1 = 26, % 26 = 0, + A = A
      # (26 - 0)/26 = 1
      # 1 - 1 = 0, % 26 = 0, + A = A
   # 29 => AC
      # 29 - 1 = 28, % 26 = 2, + A = C
      # (28 - 2)/26 = 1
      # 1 - 1 = 0, % 26 = 0, + A = A
   # 55 => BC
      # 55 - 1 = 54, % 26 = 2, + A = C
      # (54 - 2)/26 = 2
      # 2 - 1 = 1, % 26 = 1, + A = B

end

class Row
   include Mongoid::Document
   embedded_in :sheet
   
end

