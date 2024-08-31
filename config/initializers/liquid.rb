# require 'liquid'
require 'liquid/c'

module LiquidHandler
  def self.call(template, source)
    "
    content_for_layout = self.view_flow.get(:layout)
    local_assigns[\"content_for_layout\"] = content_for_layout if content_for_layout
    @output_buffer.safe_append=Liquid::Template.parse(\"#{source.to_s.gsub('"', '\\"')}\").render(local_assigns)
    @output_buffer
    "
  end
end


# Liquid::Template.register_filter(Liquid::C::Filters)
# Liquid::Template.register_tag(Liquid::C::Tags)
ActionView::Template.register_template_handler(:liquid, LiquidHandler)
