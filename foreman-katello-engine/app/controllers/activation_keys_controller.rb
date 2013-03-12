class ActivationKeysController < ApplicationController
  def index
    if org = Organization.find_by_id(params[:environment_id])
      if match = org.name.match(/\Akt-\[(.*)\]\[(.*)\]\Z/)
        org_name, env_name = match[1], match[2]
      end
    end

    ak_data = ForemanKatelloEngine::Bindings.activation_keys_to_subscriptions(org_name, env_name)
    render :status => 200, :json => ak_data, :content_type => 'application/json'
  end
end
