module UiBibz::Ui::Ux
  class Code < UiBibz::Ui::Core::Component

    def initialize content = nil, options = nil, html_options = nil, &block
      super
      @is_not_block = block.nil?
    end

    def render
      content_tag :div, class: 'usage' do
        concat title
        concat sentence
        concat UiBibz::Ui::Core::Cards::Card.new(code_html, nil, class: 'highlight code').render
      end
    end

  private

    def title
      content_tag :h2, UiBibz::Ui::Core::Glyph.new('book', { text: 'Usage' }).render
    end

    def sentence
      content_tag :div do
        concat "A Ui Bibz component consists of 3 arguments:"
        concat component_elements_list
      end
    end

    def component_elements_list
      UiBibz::Ui::Ux::ComponentListOption.new.tap do |clo|
        clo.list 'content', { types: %w(value block) }
        clo.list 'options', types: :hash
        clo.list 'html_options', types: :hash
      end.render
    end

    def formatter
      Rouge::Formatters::HTML.new
    end

    def lexer
      Rouge::Lexers::Ruby.new
    end

    def code_html
      Rouge::Formatters::HTMLPygments.new(formatter).format(lexer.lex(template))
    end

    def template
      if @is_not_block
        component_name = options[:component_name] || "content"
        "\n #{ content } #{ component_name }, options = {}, html_options = {} \n # or \n #{ content } options = {}, html_options = {} do \n   #{ component_name } \n end"
      else
        "\n#{ content }"
      end
    end

  end
end