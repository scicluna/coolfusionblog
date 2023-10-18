<!--- logout logic --->
<cfscript>
    AuthService = new cfcblog2.controllers.AuthController(session.user);
    AuthService.logout();
</cfscript>
<!--- reroute home --->
<cflocation url="/cfcblog2" >