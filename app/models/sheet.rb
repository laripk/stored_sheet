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
