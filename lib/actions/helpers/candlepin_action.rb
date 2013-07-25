module Actions
  module Helpers
    module CandlepinAction

      # TODO: update the client code to not use global state for passing user info
      #       and remove
      def as_cp_user
        Thread.current['cp_user'] = input['cp_user']
        yield
      ensure
        Thread.current['cp_user'] = nil
      end

    end
  end
end
