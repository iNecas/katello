module Actions
  module Helpers
    module PulpAction

      # TODO: update the client code to not use global state for passing user info
      def as_pulp_user
        # TODO: this is thread-dangerous as hell
        Util::ThreadSession::UserModel.set_pulp_config(input['pulp_user'])
        yield
      end

    end
  end
end
