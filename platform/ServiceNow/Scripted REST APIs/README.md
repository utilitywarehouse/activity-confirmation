These scripted REST APIs handle the backend of our suspicious reporting mechanism, validating auth and the API request if someone reports behaviour as suspicious.

If you rename them, you will need to also update the names in [confirm.html](../UI%20Pages/confirm.html)

## oidc-login.js
This endpoint is used to initiate IDP SSO.
This script confirms session details, builds the redirect URL with required scope and other metadata for OIDC flow, and redirects the user to the IDP login.

## oidc-callback.js
This endpoint is used to authenticate confirmed activity.
This script handles the OIDC callback from the IDP. It will first verify the session and OIDC callback parameter, it will then exchange the code for an ID token from the IDP, which it will parse and update the confirm_activity table with the confirmation outcome and other data from the ID token.

## suspicious.js
This endpoint is used to mark suspicious activity and due to the nature of this, no authentication is required.
This script will confirm session details and mark activity as suspicious in the confirm_activity table.
