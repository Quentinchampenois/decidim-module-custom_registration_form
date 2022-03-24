# frozen_string_literal: true

if !Rails.env.production? || ENV["SEED"]
  Rails.logger.info("Creating custom registration content blocks fields...")

  organization = Decidim::Organization.first

  Decidim::ContentBlock.create(
    decidim_organization_id: organization.id,
    weight: 1,
    scope_name: "signup_form",
    images: {},
    manifest_name: "gender",
    published_at: Time.zone.now,
    settings: nil,
    scoped_resource_id: nil
  )
end
