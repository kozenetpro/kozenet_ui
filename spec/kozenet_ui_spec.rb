# frozen_string_literal: true

RSpec.describe KozenetUi do
  it "has a version number" do
    expect(KozenetUi::VERSION).not_to be nil
  end

  it "has a working ButtonComponent" do
    expect(defined?(KozenetUi::ButtonComponent)).to eq("constant")
    expect(KozenetUi::ButtonComponent.ancestors).to include(KozenetUi::BaseComponent)
  end

  it "has a working HeaderComponent" do
    expect(defined?(KozenetUi::HeaderComponent)).to eq("constant")
    expect(KozenetUi::HeaderComponent.ancestors).to include(KozenetUi::BaseComponent)
  end

  it "has a version string in the correct format" do
    expect(KozenetUi::VERSION).to match(/^\d+\.\d+\.\d+$/)
  end
end
