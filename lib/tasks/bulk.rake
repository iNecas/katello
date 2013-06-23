task :bulk => [:environment] do
  repos = ['zoo', 'foo', 'bar']
  Katello::Bus.messaged.trigger(Katello::Actions::SyncRepositories, repos)
end
