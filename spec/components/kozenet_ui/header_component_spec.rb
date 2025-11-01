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
      header.with_action_button(href: "/cart", icon: :cart, label: "Cart")
    end

    expect(page).to have_css("a.kz-action-btn[href='/cart']")
  end

  it "renders CTA" do
    render_inline(described_class.new) do |header|
      header.with_cta(href: "/signup") { "Sign up" }
    end

    expect(page).to have_css("a.kz-cta[href='/signup']")
    expect(page).to have_text("Sign up")
  end

  it "renders mobile menu trigger" do
    render_inline(described_class.new)

    expect(page).to have_css("button.kz-mobile-trigger")
  end

  it "renders heroicon directly" do
    render_inline(described_class.new) do |header|
      header.with_action_button(href: "/user", icon: :user_plus, label: "User")
    end

    expect(page).to have_css("a.kz-action-btn[href='/user']")
    # Optionally, check for SVG or heroicon class
    expect(page).to have_css("svg")
  end
end
# rubocop:enable Metrics/BlockLength
