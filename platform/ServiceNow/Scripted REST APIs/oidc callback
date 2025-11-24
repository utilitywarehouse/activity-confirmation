(function process( /*RESTAPIRequest*/ request, /*RESTAPIResponse*/ response) {
    var client_id = "<insert your app client id here>";
	var token_endpoint = "<insert token endpoint here>";

    // get session data
    var session = gs.getSession();
    var state = session.getClientData('confirm_activity_state');
    var nonce = session.getClientData('confirm_activity_nonce');
    var verifier = session.getClientData('confirm_activity_verifier');
    var activityID = session.getClientData('confirm_activity_id');

    if (!activityID || !state || !nonce || !verifier) {
        return new sn_ws_err.BadRequestError('session data not found');
    }

    var code = "";
    var returnedState = "";

    var queryParams = request.queryParams;
    if (queryParams.code.length === 1) {
        code = queryParams.code[0];
    }
    if (queryParams.state.length === 1) {
        returnedState = queryParams.state[0];
    }

    if (returnedState != state) {
        gs.error('oidc state doesnt match');
        return new sn_ws_err.BadRequestError('oidc state doesnt match');
    }

    // if there is no code then it might be an error response
    if (code == "") {
        // query params will contain error msg
        var errMesg = JSON.stringify(queryParams);
        gs.error(errMesg);
        return new sn_ws_err.BadRequestError(errMesg);
    }

    // state is valid so exchange code to get access and id token
    try {
        var reqToken = new sn_ws.RESTMessageV2();
        reqToken.setHttpMethod("POST");
        reqToken.setEndpoint(token_endpoint);
        reqToken.setQueryParameter("grant_type", "authorization_code");
        reqToken.setQueryParameter("client_id", client_id);
        reqToken.setQueryParameter("code_verifier", verifier);
        reqToken.setQueryParameter("code", code);
        reqToken.setQueryParameter("redirect_uri", gs.getProperty("glide.servlet.uri") + "api/utw/confirm_activity/oidc-callback");
        reqToken.setRequestHeader("Accept", "application/json");
        reqToken.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

        var respToken = reqToken.execute();
    } catch (ex) {
        gs.error(ex);
        return new sn_ws_err.BadRequestError('error in exchanging code');
    }

    // validate response status and then parse body
    if (respToken.getStatusCode() !== 200) {
        gs.error("received non-ok status:" + respToken.getStatusCode() + " body:" + respToken.getBody());
        return new sn_ws_err.BadRequestError(respToken.getBody());
    }
    var responeData = JSON.parse(respToken.getBody());

    // parse JWT
    try {
        var idToken = JSON.parse(GlideStringUtil.base64Decode(responeData.id_token.split('.')[1]));
    } catch (e) {
        gs.error("unable to parse jwt err:" + e);
        return new sn_ws_err.BadRequestError('invalid request');
    }

    // verify nounce
    if (idToken.nonce != nonce) {
        gs.error("invalid nonce");
        return new sn_ws_err.BadRequestError('invalid token');
    }

    // verify audiance
    if (idToken.aud !== client_id) {
        gs.error("invalid audiance");
        return new sn_ws_err.BadRequestError('invalid token');
    }

    var activity = new GlideRecord('u_confirm_activity');
    var found = activity.get("sys_id",activityID);

    if (!found) {
        gs.error("given activityID not found id:" + activityID);
        return new sn_ws_err.BadRequestError('invalid request');
    }

    // check if already updated
    if (activity.u_response_outcome != "") {
        gs.error("activity outcome is already reported id:" + activityID + " outcome:" + activity.u_response_outcome);
        return new sn_ws_err.BadRequestError('invalid request');
    }

    // update table with response token data
    activity.u_response_outcome = "confirm";
    activity.u_response_ts = new GlideDateTime();
    activity.u_response_from_ip = request.headers["x-forwarded-for"];
    activity.u_response_from_oktaid = idToken.sub;
    activity.u_response_from_email = idToken.email;
    activity.update();

    // send user to same page to show confirmation
    response.setLocation(gs.getProperty("glide.servlet.uri") + "/confirm?id=" + activityID);
    response.setStatus(302);
})(request, response);
