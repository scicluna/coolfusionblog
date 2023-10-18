<cfscript>
    PAGINATION = 4;
    blogService = new cfcblog2.controllers.BlogController();
    posts = blogService.getPosts(1, PAGINATION);
</cfscript>

<!--- LandingPage --->
<cfsavecontent variable="includes.contentBlock" >
    <section class="h-[80dvh] flex p-4">
        <div class="flex flex-col gap-2 w-full text-3xl">
            <cfif structKeyExists(session,"loggedIn")>
                <a href="/cfcblog2/views/createpost.cfm" class="text-2xl text-blue-500 hover:text-blue-700">Create Post</a>
            </cfif>
            <cfif posts.recordCount GT 0>
                <cfoutput >
                    <div class="grid grid-rows-2 grid-cols-2">
                        <cfloop query="posts">
                            <div class="flex flex-col gap-2 p-8 h-[40dvh] items-center break-words overflow-auto">
                                <div class="flex justify-start w-full">
                                    <h1>#posts.title#</h1>
                                </div>
                                <p class="w-full">#posts.created_at#</p>
                                <p class="w-full">#posts.content#</p>
                            </div>
                        </cfloop>
                    </div>      
                </cfoutput>
            <cfelse>
                <p>No Posts Yet...</p>
            </cfif> 
        </div>
    </section> 
</cfsavecontent>

<cfinclude template="layouts/baseLayout.cfm" >


