(function process( /*RESTAPIRequest*/ request, /*RESTAPIResponse*/ response) {
    var client_id = "<insert client ID here>";
	  var oidc_login_url = "<insert oidc login url here>"

    var session = gs.getSession();
    var csrfToken = session.getClientData('confirm_activity_csrf_token');

    // check query parameter
    var activityID = "";
    var reqCsrfToken = "";

    var queryParams = request.queryParams;
    if (queryParams.activityID.length === 1) {
        activityID = queryParams.activityID[0];
    }
    if (queryParams.csrfToken.length === 1) {
        reqCsrfToken = queryParams.csrfToken[0];
    }

    if (reqCsrfToken != csrfToken) {
        return new sn_ws_err.BadRequestError('invalid session');
    }
	
    // make sure given activity ID is valid
    var activity = new GlideRecord('u_confirm_activity');
    var found = activity.get("sys_id", activityID);

    if (!found) {
        gs.error("given activityID not found id:" + activityID);
        return new sn_ws_err.BadRequestError('invalid request');
    }

    // generate oidc flow state data
    var state = GlideSecureRandomUtil.getSecureRandomString(40);
    var nonce = GlideSecureRandomUtil.getSecureRandomString(40);
    // The code_verifier must have a minimum length of 43 characters and a maximum length of 128 characters..
    var verifier = GlideSecureRandomUtil.getSecureRandomString(50);

    // store oidc flow state data in session
    session.putClientData('confirm_activity_state', state);
    session.putClientData('confirm_activity_nonce', nonce);
    session.putClientData('confirm_activity_verifier', verifier);
    session.putClientData('confirm_activity_id', activityID);

    // calculate code challenge base64url(sha256(code_verifier))
    var digest = new GlideDigest();
    var code_verifier = digest.getSHA256Base64(verifier);
    // code_verifier should be base64url encoded 
    code_verifier = code_verifier.replace(/\+/g, '-').replace(/\//g, '_').replace(/=+$/, '');

    // construct oidc auth url
    redirect = oidc_login_url;
    redirect += "response_type=code";
    redirect += "&client_id=" + client_id;
    redirect += "&redirect_uri=" +
        gs.getProperty("glide.servlet.uri") + "api/utw/confirm_activity/oidc-callback";
    redirect += "&scope=openid+email";
    redirect += "&state=" + state;
    redirect += "&nonce=" + nonce;
    redirect += "&code_challenge_method=S256";
    redirect += "&code_challenge=" + code_verifier;

    // redirect user for auth
    response.setLocation(redirect);
    response.setStatus(302);
})(request, response);
