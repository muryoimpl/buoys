# frozen_string_literal: true

module Buoys
  class Loader
    class << self
      #
      # buoy :account do
      #   link 'Account', account_path
      # end
      #
      # buoy :account_edit do |account|
      #   link 'Account Edit', edit_account_path(account)
      #   pre_buoy :account
      # end
      def buoy(key, &block)
        buoys[key] = block
      end
      alias crumb buoy

      def buoys
        @buoys ||= {}
      end

      def loaded_times
        @loaded_times ||= []
      end

      def load_buoys_files
        return unless need_reload?

        buoys.clear
        loaded_times.clear

        buoy_files.each do |file|
          instance_eval File.read(file), file
          loaded_times << File.mtime(file)
        end
      end

      def buoy_files
        Dir[*Buoys.buoy_file_paths]
      end

      def need_reload?
        return true if buoys.empty?

        Rails.env.development? && loaded_times != buoy_files.map {|f| File.mtime(f) }
      end
    end
  end
end
