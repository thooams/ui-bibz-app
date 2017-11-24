module UiBibz::Ui::Ux
  class ComponentListOption < UiBibz::Ui::Core::Component

    def initialize content = nil, options = nil, html_options = nil, &block
      super
      @items = []
    end

    def list name = nil, options = nil, html_options = nil, &block
      if is_tap(name, options)
        options = {} if options.nil?
        options[:tree] = ComponentListOption.new.tap(&block).render
        @items << ComponentListOptionList.new(name, options, html_options).render
      else
        @items << ComponentListOptionList.new(name, options, html_options, &block).render
      end
    end

    def status_link
      list(option_link('status'), { types: :symbol, values: UiBibzApp::Application::STATUSES.map{ |s| ":#{ s }" } })
    end

    def glyph_link
      list(option_link('glyph'), { types: %w(string hash) })
    end

    def table_link
      list(link_to("table_options", components_tables_table_path), { types: :hash })
    end

    def size_link
      list(option_link('size'), { types: :symbol, values: %w(:lg :md :sm) })
    end

    def state_link
      list(option_link('state'), { types: :symbol, values: %w(:disabled :active) })
    end

    def append_and_prepend_list
      list('append', types: 'html', description: "Add a content before the field")
      list('prepend', types: 'html', description: "Add a content after the field")
    end

    def tap_link text = nil
      list('tap', { types: :boolean, description: "*Required #{ text || 'if you want add <code>header</code>, <code>body</code> or <code>footer</code> item.' }".html_safe })
    end

    def inherit_component name = nil, path = nil, other_name = nil
      list(name, description: inherit_component_link(other_name || name, path))
    end

    def render
      content_tag :ul, @items.join.html_safe, class: 'list-options'
    end

  private

    def inherit_component_link name = nil, path = nil
      "(inherit of #{ link_to(path.nil? ? 'component' : name, path || component_path) })"
    end

    def option_link opt
      link_to opt, component_path(anchor: opt)
    end

    def is_tap content, options
      (content[:tap] if content.kind_of?(Hash)) || (options[:tap] unless options.nil?)
    end

  end
end
