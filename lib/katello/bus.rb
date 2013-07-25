module Katello
  module Bus

    def self.async
      self.persisted
    end

    def self.persisted
      @persisted ||= Dynflow::Bus::ActiveRecordBus.new
    end

  end
end
