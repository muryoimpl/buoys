# frozen_string_literal: true

module Buoys
  class Buoy
    attr_reader :previous, :context

    # buoy :account do
    #   link 'Account', account_path
    # end
    #
    # buoy :account_edit do |account|
    #   link 'Account Show', show_account_path(account)
    #   link 'Account Edit', edit_account_path(account)
    #   pre_buoy :account
    # end
    def initialize(context, key, *args)
      block = Buoys::Loader.buoys[key]
      raise ArgumentError, "Buoys :#{key} is not found" unless block

      @key = key
      @context = context
      instance_exec(*args, &block)
    end

    def link(key, *args)
      options = args.extract_options!
      path = args.shift
      url = path ? context.url_for(path) : nil

      text = I18n.t(key, scope: 'buoys.breadcrumbs', default: key)

      links << Buoys::Link.new(text, url, options)
    end

    def links
      @links ||= []
    end

    def pre_buoy(key, *args)
      @previous = Buoys::Buoy.new(context, key, *args)
    end
    alias parent pre_buoy

    def method_missing(method, *args, **kwargs, &block)
      context.send(method, *args, **kwargs, &block)
    end
  end
end
