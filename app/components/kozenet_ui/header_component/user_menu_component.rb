# frozen_string_literal: true

module KozenetUi
  class HeaderComponent < BaseComponent
    # UserMenu section for the HeaderComponent
    # Renders a user menu dropdown or avatar in the header
    #
    # @example
    #   <%= render KozenetUi::HeaderComponent::UserMenuComponent.new(user_name: "Test User", avatar_url: nil) do %>
    #     <%= link_to "Profile", profile_path %>
    #     <%= link_to "Logout", logout_path, method: :delete %>
    #   <% end %>
    class UserMenuComponent < BaseComponent
      def initialize(user_name: nil, avatar_url: nil, **html_options)
        super(**html_options)
        @user_name = user_name
        @avatar_url = avatar_url
      end
    end
  end
end
