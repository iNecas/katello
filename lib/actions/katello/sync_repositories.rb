module Actions
  module Katello
    class SyncRepositories < Dynflow::Action

      def plan(repos)
        repos.each do |repo|
          plan_action( SyncRepository, 'name' => repo)
        end
      end

    end
  end
end
