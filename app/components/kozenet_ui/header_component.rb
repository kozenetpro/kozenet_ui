# frozen_string_literal: true

module KozenetUi
  class HeaderComponent < BaseComponent
    renders_one :brand, "KozenetUi::HeaderComponent::BrandComponent"
    renders_one :search, "KozenetUi::HeaderComponent::SearchComponent"
    renders_many :nav_items, "KozenetUi::HeaderComponent::NavItemComponent"
    renders_many :action_buttons, "KozenetUi::HeaderComponent::ActionButtonComponent"
    renders_one :cta, "KozenetUi::HeaderComponent::CtaComponent"
    renders_one :user_menu, "KozenetUi::HeaderComponent::UserMenuComponent"
    renders_one :mobile_menu

    def initialize(
      sticky: true,
      blur: true,
      **html_options
    )
      super(**html_options)
      @sticky = sticky
      @blur = blur
    end

    private

    def base_classes
      classes = ["kz-header"]
      classes << "kz-header-sticky" if @sticky
      classes << "kz-header-blur" if @blur
      classes.join(" ")
    end
  end
end
