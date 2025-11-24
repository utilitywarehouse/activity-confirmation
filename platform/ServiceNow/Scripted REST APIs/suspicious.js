(function process( /*RESTAPIRequest*/ request, /*RESTAPIResponse*/ response) {
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
        gs.error("csrf token doesnt match");
        return new sn_ws_err.BadRequestError('invalid session');
    }

    // search for activity
    var activity = new GlideRecord('u_confirm_activity');
    var found = activity.get("sys_id", activityID);

    if (!found) {
        gs.error("no activity not found id:" + activityID);
        return new sn_ws_err.BadRequestError('invalid request');
    }

    // check if already updated
    if (activity.u_response_outcome != "") {
        gs.error("activity outcome is already reported id:" + activityID + " outcome:" + activity.u_response_outcome);
        return new sn_ws_err.BadRequestError('invalid request');
    }

    activity.u_response_outcome = "suspicious";
    activity.u_response_ts = new GlideDateTime();
    activity.u_response_from_ip = request.headers["x-forwarded-for"];
    activity.update();

    // send user to same page to show confirmation
    response.setLocation(gs.getProperty("glide.servlet.uri") + "/confirm?id=" + activityID);
    response.setStatus(302);
})(request, response);
