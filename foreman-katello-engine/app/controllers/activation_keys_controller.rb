class ActivationKeysController < ApplicationController
  def index
    # TODO: load relevant activation keys form Katello
    sample_data = {
      "Dev" => {
        "rhel6selfservice" => ["Red Hat Enterprise Linux 6 Server Self-Service"],
        "katello-and-friends" => ["Katello", "Pulp", "Candlepin", "Foreman"],
        "headpin-and-friends" => ["Headpin", "Thumbslug", "Candlepin"]
      },
      "Test" => {
        "rhel6selfservicetest" => ["Red Hat Enterprise Linux 6 Server Self-Service"]
      },
      "Prod" => {
        "rhel6highavailablility" => ["Red Hat Enterprise Linux 6 Server High Availability"]
      }
    }

    if org = Organization.find_by_id(params[:environment_id])
      if match = org.name.match(/\Akt-\[(.*)\]\[(.*)\]\Z/)
        org_name, env_name = match[1], match[2]
      end
    end

    ak_data = sample_data[env_name] || {}
    render :status => 200, :json => ak_data, :content_type => 'application/json'
  end
end
