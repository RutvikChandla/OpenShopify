class SqlTemplate < ApplicationRecord

  class Resolver < ActionView::Resolver
    protected

    def _find_all(name, prefix, partial, details, key, locals = [])
      puts "name: #{name}"
      puts "prefix: #{prefix}"
      puts "partial: #{partial}"
      puts "details: #{details}"
      puts "key: #{key.inspect}"
      puts "locals: #{locals}"

      find_templates(name, prefix, partial, locals)
    end

    def find_templates(name, prefix, partial, locals)
      conditions = {
        path: normalize_path(name, prefix),
        partial: partial || false
      }

      puts

      # if locals && locals.length > 0
      #   conditions["theme_id"] = locals[0]
      # end

      puts "conditions: #{conditions}"
      SqlTemplate.where(conditions).map do |record|
        initialize_template(record, locals)
      end
    end

    def normalize_path(name, prefix)
      prefix.present? ? "#{prefix}/#{name}" : name
    end

    def normalize_array(array)
      array.map(&:to_s)
    end

    def initialize_template(record, locals)
      source = record.body
      identifier = "SqlTemplate - #{record.id} - #{record.path.inspect}"
      handler = ActionView::Template.handler_for_extension(:liquid)
      virtual_path = virtual_path(record.path, record.partial)
      ActionView::Template.new(source, identifier, handler, format: :html, virtual_path: virtual_path, locals: locals)
    end

    def virtual_path(path, partial)
      return path unless partial
      if index = path.rindex("/")
        path.insert(index + 1, "_")
      else
        "_#{path}"
      end
    end
  end

  class SqlFileSystem
    def read_template_file(template_path)
      puts "template_path: #{template_path}"
      template_path
    end
  end

  def to_s
    body
  end
end
