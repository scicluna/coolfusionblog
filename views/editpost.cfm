<cfscript>
    authService = new cfcblog2.controllers.AuthController(session.user);
    blogService = new cfcblog2.controllers.BlogController();
    postToEdit = blogService.getPostById(url.postid);

    if(authService.isLoggedIn() == false){
        location('/cfcblog2/index.cfm');
    }

    if (structKeyExists(url,"postid") == false){
        location('/cfcblog2/index.cfm');
    }

    if (NOT authService.authPost(url.postid)){
        location('/cfcblog2/index.cfm');
    }


    if (CGI.REQUEST_METHOD == "POST" AND structKeyExists(form,"title") AND structKeyExists(form,"content")){
        newPost = new cfcblog2.models.Post({
            title = form.title,
            content = form.content
        });
        blogService.editPostById(url.postid,newPost);
        origin = structKeyExists(url,origin) ? url.origin : '/cfcblog2/index.cfm';
        location(origin);
    } else if (CGI.REQUEST_METHOD != "GET"){
        location('/cfcblog2/index.cfm')
    }

</cfscript>

<cfoutput >
<cfsavecontent variable="includes.contentBlock">
    <div class="h-full flex justify-center items-center">
        <form method="POST" action="editpost.cfm?postid=#url.postid#&origin=#url.origin#" class="flex flex-col w-3/4 gap-1">
            <label for="title" >Title</label>
            <input name="title" class="w-1/4" value="#postToEdit.title#">
            <label for="content" >Content</label>
            <textarea name="content" rows="15">#postToEdit.content#</textarea>
            <div class="flex justify-center">
                <button type="submit" class="bg-slate-400 w-fit p-2 rounded-lg text-3xl text-slate-100">Submit</button>
            </div>
        </form>
    </div>
</cfsavecontent>
</cfoutput>

<!--- actually call the template --->
<cfinclude template="../layouts/baseLayout.cfm" >
