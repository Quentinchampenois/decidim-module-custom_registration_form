# frozen_string_literal: true

require "spec_helper"

module Decidim
  module Comments
    describe CreateRegistration do
      describe "call" do
        let(:organization) { create(:organization) }

        let(:name) { "Username" }
        let(:nickname) { "nickname" }
        let(:email) { "user@example.org" }
        let(:password) { "Y1fERVzL2F" }
        let(:password_confirmation) { password }
        let(:tos_agreement) { "1" }
        let(:newsletter) { "1" }
        let(:current_locale) { "es" }
        let(:extended_data) { { "custom_registration_form" => {} } }

        let(:form_params) do
          {
            "user" => {
              "name" => name,
              "nickname" => nickname,
              "email" => email,
              "password" => password,
              "password_confirmation" => password_confirmation,
              "tos_agreement" => tos_agreement,
              "newsletter_at" => newsletter
            }
          }
        end
        let(:form) do
          RegistrationForm.from_params(
            form_params,
            current_locale: current_locale
          ).with_context(
            current_organization: organization
          )
        end
        let(:command) { described_class.new(form) }

        describe "when the form is not valid" do
          before do
            expect(form).to receive(:invalid?).and_return(true)
          end

          it "broadcasts invalid" do
            expect { command.call }.to broadcast(:invalid)
          end

          it "doesn't create a user" do
            expect do
              command.call
            end.not_to change(User, :count)
          end

          context "when the user was already invited" do
            let(:user) { build(:user, email: email, organization: organization) }

            before do
              user.invite!
              clear_enqueued_jobs
            end

            it "receives the invitation email again" do
              expect do
                command.call
                user.reload
              end.to change(User, :count).by(0)
                                         .and broadcast(:invalid)
                .and change(user.reload, :invitation_token)
              expect(ActionMailer::MailDeliveryJob).to have_been_enqueued.on_queue("mailers")
            end
          end
        end

        describe "when the form is valid" do
          it "broadcasts ok" do
            expect { command.call }.to broadcast(:ok)
          end

          it "creates a new user" do
            expect(User).to receive(:create!).with(
              name: form.name,
              nickname: form.nickname,
              email: form.email,
              password: form.password,
              password_confirmation: form.password_confirmation,
              tos_agreement: form.tos_agreement,
              newsletter_notifications_at: form.newsletter_at,
              email_on_notification: true,
              organization: organization,
              accepted_tos_version: organization.tos_version,
              locale: form.current_locale,
              extended_data: extended_data
            ).and_call_original

            expect { command.call }.to change(User, :count).by(1)
          end

          context "when custom registration fields are enabled" do
            let(:organization) { create(:organization, :custom_registration_form_enabled) }

            it "creates a new user" do
              expect(User).to receive(:create!).with(
                name: form.name,
                nickname: form.nickname,
                email: form.email,
                password: form.password,
                password_confirmation: form.password_confirmation,
                tos_agreement: form.tos_agreement,
                newsletter_notifications_at: form.newsletter_at,
                email_on_notification: true,
                organization: organization,
                accepted_tos_version: organization.tos_version,
                locale: form.current_locale,
                extended_data: extended_data
              ).and_call_original

              expect { command.call }.to change(User, :count).by(1)
            end

            context "and custom registration field are defined" do
              let(:gender) { "0" }
              let(:extended_data) { { "custom_registration_form" => { "gender" => "0" } } }
              let(:form_params) do
                {
                  "user" => {
                    "name" => name,
                    "nickname" => nickname,
                    "email" => email,
                    "password" => password,
                    "password_confirmation" => password_confirmation,
                    "tos_agreement" => tos_agreement,
                    "newsletter_at" => newsletter,
                    "gender" => gender
                  }
                }
              end

              before do
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

              it "saves gender in extended data" do
                expect(User).to receive(:create!).with(
                  name: form.name,
                  nickname: form.nickname,
                  email: form.email,
                  password: form.password,
                  password_confirmation: form.password_confirmation,
                  tos_agreement: form.tos_agreement,
                  newsletter_notifications_at: form.newsletter_at,
                  email_on_notification: true,
                  organization: organization,
                  accepted_tos_version: organization.tos_version,
                  locale: form.current_locale,
                  extended_data: extended_data
                ).and_call_original

                expect { command.call }.to change(User, :count).by(1)
              end
            end
          end

          describe "when user keeps the newsletter unchecked" do
            let(:newsletter) { "0" }

            it "creates a user with no newsletter notifications" do
              expect do
                command.call
                expect(User.last.newsletter_notifications_at).to eq(nil)
              end.to change(User, :count).by(1)
            end
          end
        end
      end
    end
  end
end
