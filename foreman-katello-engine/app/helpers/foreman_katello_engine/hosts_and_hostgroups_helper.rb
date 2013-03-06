module ForemanKatelloEngine
  module HostsAndHostgroupsHelper

    def activation_key_input
      path = ""
      method = :activation_key
      options = {:class => "auto_complete_input"}
      completion_options = {}
      text_field_tag(method, nil, options) +
        auto_complete_clear_value_button(method) +
        auto_complete_field_jquery(method, "#{path}/auto_complete_#{method}", completion_options)
    end

    def kt_ak_label
      "kt_activation_keys"
    end

  end
end
