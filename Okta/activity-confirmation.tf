resource "okta_app_oauth" "activity-confirmation" {
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
