module UiBibz::Ui::Ux
  class Example < UiBibz::Ui::Core::Card

    def initialize content = nil, options = nil, html_options = nil, &block
      super
      @items = [@content]
    end

    def code content = nil, options = nil, html_options = nil, &block
      @code = UiBibz::Ui::Core::Component.new(content, options, html_options, &block)
      @items << content_tag(:div, code_html, class: "card-block highlight")
    end

    def other_classes
      "card-code"
    end

    private

    def code_html
      formatter = Rouge::Formatters::HTML.new(css_class: 'highlight', wrap: false)
      lexer = Rouge::Lexers::Ruby.new
      content_tag :pre, ("\n" + formatter.format(lexer.lex(@code.content))).html_safe
    end

  end
end
