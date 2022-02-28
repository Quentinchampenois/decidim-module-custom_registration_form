# frozen_string_literal: true

module Decidim
  describe CustomRegistrationForm do
    subject { described_class }

    describe "#version" do
      it "returns module's version" do
        expect(subject.version).to eq("0.0.1")
      end
    end

    describe "#decidim_compatibility_version" do
      it "returns Decidim versions compatibility" do
        expect(subject.decidim_compatibility_version).to eq("0.26.0")
      end
    end
  end
end
