Gem::Specification.new do |s|
  s.name = "foreman-katello-engine"
  s.version = "0.0.3"

  s.authors = ["Katello"]
  s.date = "2013-03-04"
  s.description = "Katello specific parts of Foreman"
  s.email = "katello-devel@redhat.com"
  s.files = `git ls-files`.split("\n")
  s.homepage = "http://katello.org"
  s.licenses = ["GPL-2"]
  s.require_paths = ["lib"]
  s.add_dependency "katello_api"
  s.summary = "Katello specific parts of Foreman"
end
