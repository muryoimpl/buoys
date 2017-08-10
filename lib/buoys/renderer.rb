# frozen_string_literal: true

module Buoys
  class Renderer
    def initialize(context, key, *args)
      @context = context
      @key = key
      @args = args

      Buoys::Loader.load_buoys_files
    end

    def render
      return [] unless @key

      buoy = Buoys::Buoy.new(@context, @key, *@args)
      build_links(buoy)
    end

    private

    def build_links(buoy)
      links = buoy.links.dup

      links.unshift(*collect_previous_links(buoy))
      links.last.mark_as_current!

      links
    end

    def collect_previous_links(buoy)
      links = []

      buoy = buoy.previous
      while buoy
        links.unshift(*buoy.links)
        buoy = buoy.previous
      end

      links
    end
  end
end
