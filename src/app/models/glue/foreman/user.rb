

module Glue::Foreman::User
  def self.included(base)
    base.send :include, InstanceMethods
    base.class_eval do
      before_save :save_foreman_orchestration
      before_destroy :destroy_foreman_orchestration
    end
  end

  module InstanceMethods
    def foreman_user
      @foreman_user ||= ::Foreman::User.find foreman_id
    end

    def save_foreman_orchestration
      case orchestration_for
        when :create
          pre_queue.create :name   => "create foreman user: #{username}", :priority => 3,
                           :action => [self, :create_foreman_user]
        when :update
          pre_queue.create :name   => "update foreman user: #{username}", :priority => 3,
                           :action => [self, :update_foreman_user]
      end
    end

    def destroy_foreman_orchestration
      pre_queue.create(:name   => "destroy foreman user: #{username}", :priority => 3,
                       :action => [self, :destroy_foreman_user])
    end

    def create_foreman_user
      @foreman_user = ::Foreman::User.create :login    => username,
                                          :mail     => email,
                                          # :admin    => true, Foreman doesn't support mass-assignment of 'admin'
                                          :password => password,
                                          :auth_source_id => 1 # hardcoded, has to come from somewhere
      self.foreman_id = @foreman_user.id
    end

    def update_foreman_user
      foreman_user.update_attributes(:mail => email, :password => password)
    end

    def destroy_foreman_user
      ::Foreman::User.delete(foreman_id)
    end
  end
end