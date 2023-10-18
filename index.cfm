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
                            <div class="flex flex-col gap-2 p-8 h-[40dvh] items-center break-words relative">
                                <div class="flex justify-start items-center w-full font-extrabold text-4xl gap-6">
                                    <h1>#posts.title#</h1>
                                    <cfif structKeyExists(session,"user") AND #posts.user_id# EQ session.user.getUserId()>
                                        <a href="/cfcblog2/views/editpost.cfm?postid=#posts.id#&origin=/cfcblog2/index.cfm" class="text-2xl font-bold text-blue-500 hover:text-blue-700">edit</a>
                                        <a href="/cfcblog2/views/deletepost.cfm?postid=#posts.id#&origin=/cfcblog2/index.cfm" class="text-2xl font-bold text-blue-500 hover:text-blue-700">delete</a>
                                    </cfif>
                                </div>
                                <p class="w-full text-xs">#posts.created_at#</p>
                                <div class="w-full h-full overflow-auto">
                                    <p class="w-full">#posts.content#</p>
                                </div>
                            </div>
                        </cfloop>
                    </div>      
                </cfoutput>
            <cfelse>
                <p>No Posts Yet...</p>
            </cfif> 
            <a href="/cfcblog2/views/allposts.cfm" class="absolute bottom-0 right-0 p-4">All posts</a>
        </div>
    </section> 
</cfsavecontent>

<cfinclude template="layouts/baseLayout.cfm" >


