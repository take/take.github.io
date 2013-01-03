module Jekyll
  require 'haml'
  class HamlConverter < Converter
    safe true
    priority :low

    def matches(ext)
      ext =~ /haml/i
    end

    def output_ext(ext)
      ".html"
    end

    def convert(content)
      engine = Haml::Engine.new(content)
      begin
        engine.render
      rescue SyntaxError => e
        puts e
        puts 'Hint:'
        puts "#{content[0..72]}"
      end
    end
  end

  require 'sass'
  class SassConverter < Converter
    safe true
    priority :low

    def matches(ext)
      ext =~ /sass/i
    end

    def output_ext(ext)
      ".css"
    end

    def convert(content)
      engine = Sass::Engine.new(content)
      begin
        engine.render
      rescue SyntaxError => e
        puts e
        puts 'Hint:'
        puts "#{content[0..72]}"
      end
    end
  end
end
