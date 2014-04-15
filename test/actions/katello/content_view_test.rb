#
# Copyright 2014 Red Hat, Inc.
#
# This software is licensed to you under the GNU General Public
# License as published by the Free Software Foundation; either version
# 2 of the License (GPLv2) or (at your option) any later version.
# There is NO WARRANTY for this software, express or implied,
# including the implied warranties of MERCHANTABILITY,
# NON-INFRINGEMENT, or FITNESS FOR A PARTICULAR PURPOSE. You should
# have received a copy of GPLv2 along with this software; if not, see
# http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt.

require 'katello_test_helper'

module ::Actions::Katello::ContentView

  class TestBase < ActiveSupport::TestCase
    include Dynflow::Testing
    include Support::Actions::Fixtures
    include FactoryGirl::Syntax::Methods

    let(:action) { create_action action_class }
  end

  class AddToEnvironmentTest < TestBase
    let(:action_class) { ::Actions::Katello::ContentView::AddToEnvironment }

    let(:environment) do
      katello_environments(:library)
    end

    let(:content_view) do
      katello_content_views(:no_environment_view)
    end

    def content_view_environment
      ::Katello::ContentViewEnvironment.where(:environment_id => environment.id, :content_view_id => content_view.id).first      
    end

    it 'plans' do
      content_view_environment.must_be_nil

      version = content_view.create_new_version
      action = create_and_plan_action(action_class, version, environment)
      assert_action_planed_with(action, EnvironmentCreate) do |(cve)|
        cve.environment.must_equal environment
        cve.content_view.must_equal content_view
      end
      content_view_environment.content_view_version.version.must_equal 1

      version = content_view.create_new_version
      action = create_and_plan_action(action_class, version, environment)
      refute_action_planed(action, EnvironmentCreate)
      content_view_environment.content_view_version.version.must_equal 2
    end
  end

  class EnvironmentCreateTest < TestBase
    let(:action_class) { ::Actions::Katello::ContentView::EnvironmentCreate }

    let(:content_view_environment) do
      katello_content_view_environments(:library_default_view_environment)
    end

    it 'plans' do
      Katello::Configuration::Node.any_instance.stubs(:use_cp).returns(true)
      content_view_environment.expects(:save!)
      plan_action(action, content_view_environment)
      content_view = content_view_environment.content_view
      assert_action_planed_with(action,
                                ::Actions::Candlepin::Environment::Create,
                                organization_label: content_view.organization.label,
                                cp_id:              content_view_environment.cp_id,
                                name:               content_view_environment.label,
                                description:        content_view.description)
    end
  end

  class CreateTest < TestBase
    let(:action_class) { ::Actions::Katello::ContentView::Create }

    let(:content_view) do
      katello_content_views(:acme_default)
    end

    it 'plans' do
      Katello::Configuration::Node.any_instance.stubs(:use_elasticsearch).returns(true)
      content_view.expects(:save!)
      content_view.expects(:disable_auto_reindex!)
      plan_action(action, content_view)
      assert_action_planed_with(action, ::Actions::ElasticSearch::Reindex, content_view)
    end
  end

  class RemoveFromEnvironmentTest < TestBase
    let(:action_class) { ::Actions::Katello::ContentView::RemoveFromEnvironment }

    let(:content_view) do
      katello_content_views(:library_dev_view)
    end

    let(:environment) do
      katello_environments(:dev)
    end

    it 'plans' do
      cve = Katello::ContentViewEnvironment.where(:content_view_id => content_view, :environment_id => environment).first
      Katello::ContentViewEnvironment.stubs(:where).returns([cve])
      cve.expects(:destroy).returns(true)

      task = ForemanTasks::Task::DynflowTask.create!(state: :success, result: "good")
      action.stubs(:task).returns(task)

      action.expects(:action_subject).with(content_view)
      plan_action(action, content_view, environment)
      assert_action_planed_with(action, ::Actions::Candlepin::Environment::Destroy, {cp_id: cve.cp_id})
    end
  end

end
