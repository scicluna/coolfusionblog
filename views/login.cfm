<cfscript>
    if(structKeyExists( form, "username" ) AND structKeyExists(form,"password") AND CGI.REQUEST_METHOD EQ "POST"  ){
        newUser = new cfcblog2.models.User({username = form.user, password = form.password});
        AuthService = new cfcblog2.controllers.AuthController({user = newUser});
        if(AuthService.login()) {
            location(url="/cfcblog2");
        } else {
            errorMessage = "Invalid username or password.";
        }
    }
</cfscript>

<!--- Kind of like a react server component --->
<cfsavecontent variable="includes.contentBlock" >
    <h1>Login Form</h1>
    <cfif isDefined("errorMessage")>
        <p>#errorMessage#</p>
    </cfif>
    <form action="login.cfm" method="post">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required>
        <br>
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required>
        <br>
        <input type="submit" value="Login">
    </form>
</cfsavecontent>

<!--- actually call the template --->
<cfinclude template="../layouts/baseLayout.cfm" >


