module Katello
  module Bus

    def self.sync
      self.persisted
    end

    def self.persisted
      @persisted ||= Dynflow::Bus::ActiveRecordBus.new
    end

    def self.messaged
      @messaged ||= MessagedBus.new
    end

    class MessagedBus < Dynflow::Bus

      def transaction_driver
        Katello::Bus.persisted.transaction_driver
      end

      def persistence_driver
        Katello::Bus.persisted.persistence_driver
      end

      def execution_driver
        @execution_driver ||= MessagedExecutor.new
      end

    end

    class MessagedExecutor < Dynflow::Executor
    end

  end
end
