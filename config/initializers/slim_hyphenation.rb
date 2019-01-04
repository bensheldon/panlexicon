# https://github.com/slim-template/slim/issues/820
module Slim
  module Splat
    class Builder
      def hyphen_attr(name, escape, value)
        if Hash === value
          value.each do |n, v|
            hyphen_attr("#{name}-#{n.to_s.gsub('_', '-')}", escape, v)
          end
        else
          attr(name, escape_html(value != true && escape, value))
        end
      end
    end
  end
end
