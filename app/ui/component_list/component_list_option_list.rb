module UiBibz::Ui::Ux
  class ComponentListOptionList < UiBibz::Ui::Core::Component

    def initialize content = nil, options = nil, html_options = nil, &block
      super
    end

    def render
      content_tag :li do
        concat content_tag :span, content, class: 'option-name'
        concat content_tag :span, types_list, class: 'option-types'         unless options[:types].nil?
        concat content_tag :span, values_list, class: 'option-values'       unless options[:values].nil?
        concat content_tag :span, required_field, class: 'option-required'  unless options[:required].nil?
        concat content_tag :span, description, class: 'option-description'  unless options[:description].nil?
        concat options[:tree]                                               unless options[:tree].nil?
      end
    end

  private

    def values_list
      "(<code>#{ [options[:values]].flatten.join(', ') }</code>)".html_safe
    end

    def types_list
      "[#{ [options[:types]].flatten.join('/') }]"
    end

    def required_field
      UiBibz::Ui::Core::Tag.new('Required', status: :danger).render
    end

    def description
      options[:description]
    end

  end
end
