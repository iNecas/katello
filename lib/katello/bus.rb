module Katello
  module Bus

    def self.async
      self.persisted
    end

    def self.persisted
      persistence_adapter = Dynflow::PersistenceAdapters::ActiveRecord.new
      @persisted ||= Dynflow::SimpleWorld.new(persistence_adapter: persistence_adapter)
    end

  end
end
