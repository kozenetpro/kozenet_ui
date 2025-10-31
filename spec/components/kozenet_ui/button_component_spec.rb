# frozen_string_literal: true

require "rails_helper"

# rubocop:disable Metrics/BlockLength
RSpec.describe KozenetUi::ButtonComponent, type: :component do
  it "renders a button with default variant" do
    render_inline(described_class.new) { "Click me" }

    expect(page).to have_css("button.kz-btn.kz-variant-primary")
    expect(page).to have_text("Click me")
  end

  it "renders with custom variant" do
    render_inline(described_class.new(variant: :secondary)) { "Secondary" }

    expect(page).to have_css("button.kz-variant-secondary")
  end

  it "renders with custom size" do
    render_inline(described_class.new(size: :lg)) { "Large" }

    expect(page).to have_css("button.kz-size-lg")
  end

  it "renders as disabled" do
    render_inline(described_class.new(disabled: true)) { "Disabled" }

    expect(page).to have_css("button[disabled]")
  end

  it "renders loading state" do
    render_inline(described_class.new(loading: true)) { "Loading" }

    expect(page).to have_css("button[aria-busy='true']")
    expect(page).to have_css(".kz-btn-spinner")
  end

  it "renders as link when href provided" do
    render_inline(described_class.new(href: "/path")) { "Link" }

    expect(page).to have_css("a.kz-btn[href='/path']")
  end

  it "renders with icon slot" do
    render_inline(described_class.new) do |button|
      button.with_icon { "<svg></svg>".html_safe }
      "With icon"
    end

    expect(page).to have_css(".kz-btn-icon")
  end

  it "renders full width" do
    render_inline(described_class.new(full_width: true)) { "Full" }

    expect(page).to have_css("button.w-full")
  end
end
# rubocop:enable Metrics/BlockLength
