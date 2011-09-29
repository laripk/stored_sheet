require 'sinatra'
require 'mongoid'


class Sheet
   include Mongoid::Document
   include Mongoid::Timestamps
   
   field :sheet_name
   embeds_many :columns
   embeds_many :rows
   
   def self.new_sheet name="Untitled", num_cols=3, num_rows=3
      cols = Column.add_cols([], num_cols)
      rows = []
      num_rows.times{ rows << {} }
      sheet = Sheet.new(sheet_name: name, 
                        columns: cols, 
                        rows: rows)
   end
   
   def [] row_index, col_index
      fieldname = fieldname_from_column(col_index)
      row = get_row(row_index)
      row[fieldname]
   end
   
   def []= row_index, col_index, value
      fieldname = fieldname_from_column(col_index)
      row = get_row(row_index)
      row[fieldname] = value
   end
   
   def each_cell_index
      self.rows.each_index do |r|
         self.columns.each_index do |c|
            yield [r, c]
         end
      end
   end
   
private
   
   def fieldname_from_column col_index
      col = self.columns[col_index]
      if col == nil
         col_min = self.columns.index self.columns.first
         col_max = self.columns.rindex self.columns.last
         raise IndexError, "column index (#{col_index}) out of range (#{col_min}..#{col_max})"
      end
      fieldname = col["field"]
   end
   
   def get_row row_index
      row = self.rows[row_index]
      if row == nil
         row_min = self.rows.index self.rows.first
         row_max = self.rows.rindex self.rows.last
         raise IndexError, "row index (#{row_index}) out of range (#{row_min}..#{row_max})"
      end
      row
   end
   
end

class Column
   include Mongoid::Document
   embedded_in :sheet
   
   field :num, type: Integer
   field :name, type: String
   field :field, type: String
   field :width, type: Integer, default: 100
   
   def self.add_cols(col_array, number_to_add)
      arr_leng = col_array.length
      number_to_add.to_i.times do |i|
         n = arr_leng + i + 1
         col = Column.new( num: n, name: col_name(n), field: "Field#{n}" )
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

