module Katello

  module Actions

    class SyncRepository < Dynflow::Action

      input_format do
        param :name, String
      end

      def run
        time = rand(10)
        sleep(time) # simulate real action
        output['time'] = time
      end

    end
  end
end
