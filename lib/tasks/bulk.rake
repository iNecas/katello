task :bulk => [:environment] do
  repos = ['zoo', 'foo', 'bar']

  # triggers a sample bulk action
  # this process just compiles the execution plan and notifies the
  # script/dynflow_delayed.rb runner about the new plan_
  Katello::Bus.messaged.trigger(Katello::Actions::SyncRepositories, repos)
end
