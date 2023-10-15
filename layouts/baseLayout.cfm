<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Template</title>
        <cfoutput>
            <link href="/#ListFirst(CGI.SCRIPT_NAME, "/")#/assets/css/ostyles.css" rel="stylesheet" />
        </cfoutput>
    </head>
    <body class="h-[100dvh] w-[100dvw] bg-white flex flex-col justify-between">
        <!--- header --->
        <cfinclude template="../components/navbar.cfm">
        
        <!--- Content from nested layouts or pages will go here --->
        <cfoutput>#includes.contentBlock#</cfoutput>
        
        <!--- footer --->
        <cfinclude template="../components/footer.cfm">
    </body>
</html>