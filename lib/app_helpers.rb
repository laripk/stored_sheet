
def fix_sheet_for_clientside sheet
   sheet.to_json.gsub('"_id":', '"id":')
end


def webdebug?
   [:development].include?(settings.environment)  # , :test
end


# copied from actionpack/lib/action_view/helpers/debug_helper.rb v3.0.8rc1 via railsapi.com
def debug(object)
   begin
      Marshal::dump(object)
      "<pre class='debug_dump'>#{html_escape(object.to_yaml).gsub("  ", "&nbsp; ")}</pre>".html_safe
   rescue Exception => e  # errors from Marshal or YAML
      # Object couldn't be dumped, perhaps because of singleton methods -- this is the fallback
      "<code class='debug_dump'>#{html_escape(object.inspect)}</code>".html_safe
   end
end
