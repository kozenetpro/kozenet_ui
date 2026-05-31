# frozen_string_literal: true

require "rails_helper"

# rubocop:disable Metrics/BlockLength
RSpec.describe KozenetUi::HeaderComponent, type: :component do
  it "renders header with default options" do
    render_inline(described_class.new)

    expect(page).to have_css("header.kz-header")
    expect(page).to have_css(".kz-header-sticky")
    expect(page).to have_css(".kz-header-blur")
  end

  it "uses component defaults from configuration" do
    original_defaults = KozenetUi.configuration.component_defaults_for(:header).dup
    KozenetUi.configuration.component(:header, sticky: false, blur: false)

    render_inline(described_class.new)

    expect(page).to have_css("header.kz-header")
    expect(page).to have_no_css(".kz-header-sticky")
    expect(page).to have_no_css(".kz-header-blur")

    render_inline(described_class.new(sticky: true, blur: true))

    expect(page).to have_css(".kz-header-sticky")
    expect(page).to have_css(".kz-header-blur")
  ensure
    KozenetUi.configuration.component(:header, original_defaults)
  end

  it "uses the configured Stimulus prefix" do
    original_prefix = KozenetUi.configuration.stimulus_prefix
    KozenetUi.configuration.stimulus_prefix = "ui"

    render_inline(described_class.new) do |header|
      header.with_mobile_menu { "Mobile nav" }
    end

    expect(page).to have_css('header[data-controller="ui-header ui-mobile-nav"]')
    expect(page).to have_css('[data-ui-header-target="container"]')
    expect(page).to have_css('[data-ui-mobile-nav-target="trigger"]')
  ensure
    KozenetUi.configuration.stimulus_prefix = original_prefix
  end

  it "renders brand" do
    render_inline(described_class.new) do |header|
      header.with_brand(href: "/") { "Logo" }
    end

    expect(page).to have_css("a.kz-brand[href='/']")
    expect(page).to have_text("Logo")
  end

  it "renders navigation items" do
    render_inline(described_class.new) do |header|
      header.with_nav_item(href: "/courses", active: true) { "Courses" }
      header.with_nav_item(href: "/pricing") { "Pricing" }
    end

    expect(page).to have_css(".kz-nav-link[href='/courses'].is-active")
    expect(page).to have_css(".kz-nav-link[href='/pricing']")
  end

  it "renders search component" do
    render_inline(described_class.new) do |header|
      header.with_search(placeholder: "Search...")
    end

    expect(page).to have_css(".kz-search-wrap")
    expect(page).to have_css("input[placeholder='Search...']")
  end

  it "renders action buttons" do
    render_inline(described_class.new) do |header|
      header.with_action_button(href: "/cart", icon: :shopping_cart, label: "Cart")
    end

    expect(page).to have_css("a.kz-action-btn[href='/cart']")
    expect(page).to have_css("a.kz-action-visible-desktop[href='/cart']")
    expect(page).to have_css(".kz-action-btn-icon svg.kz-action-btn-svg")
    expect(page).to have_no_css("img")
  end

  it "renders text action buttons" do
    render_inline(described_class.new) do |header|
      header.with_action_button(href: "/saved", text: "Check", label: "Saved")
    end

    expect(page).to have_css("a.kz-action-btn.kz-action-btn-with-text[href='/saved'][aria-label='Saved']")
    expect(page).to have_css(".kz-action-btn-text", text: "Check")
  end

  it "places action buttons in start or end groups" do
    render_inline(described_class.new) do |header|
      header.with_action_button(href: "/menu", icon: :bars3, label: "Menu", placement: :start)
      header.with_action_button(href: "/saved", icon: :heart, label: "Saved")
    end

    expect(page).to have_css(".kz-header-start-actions a.kz-action-btn[href='/menu']")
    expect(page).to have_css(".kz-header-actions a.kz-action-btn[href='/saved']")
  end

  it "accepts left and right action position aliases" do
    render_inline(described_class.new) do |header|
      header.with_action_button(href: "/left", icon: :bars3, label: "Left", position: :left)
      header.with_action_button(href: "/right", icon: :heart, label: "Right", position: :right)
    end

    expect(page).to have_css(".kz-header-start-actions a.kz-action-btn-placement-start[href='/left']")
    expect(page).to have_css(".kz-header-actions a.kz-action-btn-placement-end[href='/right']")
  end

  it "renders action button visibility classes" do
    render_inline(described_class.new) do |header|
      header.with_action_button(href: "/mobile", icon: :bars3, label: "Mobile", visible_on: :mobile)
      header.with_action_button(href: "/desktop", icon: :heart, label: "Desktop", visible_on: :desktop)
      header.with_action_button(href: "/always", icon: :bell, label: "Always", visible_on: :always)
    end

    expect(page).to have_css("a.kz-action-visible-mobile[href='/mobile']")
    expect(page).to have_css("a.kz-action-visible-desktop[href='/desktop']")
    expect(page).to have_css("a.kz-action-visible-always[href='/always']")
  end

  it "only renders the built-in mobile trigger when a mobile menu is provided" do
    render_inline(described_class.new)

    expect(page).to have_no_css("button.kz-mobile-trigger")

    render_inline(described_class.new) do |header|
      header.with_mobile_menu { "Mobile nav" }
    end

    expect(page).to have_css("button.kz-mobile-trigger")
  end

  it "renders CTA" do
    render_inline(described_class.new) do |header|
      header.with_cta(href: "/signup") { "Sign up" }
    end

    expect(page).to have_css("a.kz-cta[href='/signup']")
    expect(page).to have_text("Sign up")
  end

  it "renders mobile menu panel content" do
    render_inline(described_class.new) do |header|
      header.with_mobile_menu { "Mobile nav" }
    end

    expect(page).to have_css("button.kz-mobile-trigger")
    expect(page).to have_css(".kz-mobile-panel", text: "Mobile nav")
  end

  it "normalizes snake_case Heroicon names" do
    render_inline(described_class.new) do |header|
      header.with_action_button(href: "/user", icon: :user_plus, label: "User")
    end

    expect(page).to have_css("a.kz-action-btn[href='/user']")
    expect(page).to have_css("svg")
  end
end
# rubocop:enable Metrics/BlockLength
