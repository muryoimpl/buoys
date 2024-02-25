# frozen_string_literal: true

module Buoys
  class Link
    attr_accessor :text, :options, :options_for_config
    attr_reader :current

    CONFIG = {
      current_class: Buoys::Config.current_class || 'active',
      link_current: Buoys::Config.link_current || false
    }.with_indifferent_access

    def initialize(text, url, options)
      @options_for_config, @options = extract_options_and_config(options)
      @text = text
      @_url = url
      @current = false
    end

    def mark_as_current!
      options[:class] = config[:current_class]
      @current = true
    end

    def current?
      @current
    end

    def url
      return '' if current? && !config[:link_current]

      @_url || ''
    end

    def url=(str)
      @_url = str
    end

    private

    def config
      CONFIG.merge(options_for_config)
    end

    def extract_options_and_config(opts)
      options = opts.with_indifferent_access
      config = (options.keys & CONFIG.keys).each_with_object({}) {|key, hash|
        hash[key] = options.delete(key)
      }

      [config, options]
    end
  end
end
