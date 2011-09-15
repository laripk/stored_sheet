
def new_sheet name="Untitled"
   cols = Column.add_cols([], 3)
   sheet = Sheet.new(sheet_name: name, 
                     columns: cols, 
                     rows: [{},{},{}])
end

def webdebug?
   [:development].include?(settings.environment)  # , :test
end

def debug(object)
   begin
      Marshal::dump(object)
      "<pre class='debug_dump'>#{html_escape(object.to_yaml).gsub("  ", "&nbsp; ")}</pre>".html_safe
   rescue Exception => e  # errors from Marshal or YAML
      # Object couldn't be dumped, perhaps because of singleton methods -- this is the fallback
      "<code class='debug_dump'>#{html_escape(object.inspect)}</code>".html_safe
   end
end
