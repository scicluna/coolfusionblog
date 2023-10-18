<cfscript>
    authService = new cfcblog2.controllers.AuthController(session.user);
    blogService = new cfcblog2.controllers.BlogController();
    if (CGI.request_method == "GET" AND authService.authPost(url.postid)){
        if (structKeyExists(url, "postid")) {
            blogService.deletePostById(url.postid)
        }
    } 
    origin = structKeyExists(url,"origin") ? url.origin : '/cfcblog2/index.cfm';
    location(origin)
</cfscript>