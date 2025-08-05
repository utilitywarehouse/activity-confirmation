resource "okta_app_oauth" "activity_confirmation" {
  label       = "Activity Confirmation"
  issuer_mode = "CUSTOM_URL"
  type        = "browser"
  grant_types = ["authorization_code"]
  redirect_uris = [
    "https://<Servicenow domain>/api/utw/confirm_activity/oidc-callback", // Or your webpage of choice with an OIDC flow implemented
  ]
  response_types             = ["code"]
  status                     = "ACTIVE"
  hide_ios                   = true
  hide_web                   = true
  token_endpoint_auth_method = "none" # toggles PKCE on
  pkce_required              = true
}

  resource "okta_group" "activity_confirmation" {
      description               = "<group description>"
      name                      = "<group name>"
    }

  resource "okta_group_rule" "activity_confirmation" {
      name = "<rule name>"
      expression_type   = "urn:okta:expression:1.0"
      expression_value  = <<-EOT
            (
            (user.login != "")
            )
        EOT
      status            = "ACTIVE"
    }

  resource "okta_app_group_assignment" "activity_confirmation" {
      app_id            = okta_app_oauth.activity_confirmation.id
      group_id          = okta_group.activity_confirmation.id
    }
