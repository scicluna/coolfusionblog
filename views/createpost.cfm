<cfscript>
    blogService = new cfcblog2.controllers.BlogController();

    if (structKeyExists(form,"category") AND structKeyExists(form,"title") AND structKeyExists(form,"content")){
        newPost = new cfcblog2.models.Post({
            author = session.user,
            title = form.title,
            content = form.content,
            category = form.category
        });
        try{
        blogService.createPost(newPost);
        location('/cfcblog2/index.cfm');
        } catch(Any e) {
            writeDump(e);
        }
    }
</cfscript>

<!--- Kind of like a react server component --->
<cfsavecontent variable="includes.contentBlock" >
    <div class="h-full flex justify-center items-center">
        <form method="POST" action="createpost.cfm" class="flex flex-col w-3/4 gap-1">
            <label for="category" >Category</label>
            <input name="category" class="w-1/4">
            <label for="title" >Title</label>
            <input name="title" class="w-1/4">
            <label for="content" >Content</label>
            <textarea name="content" rows="15"></textarea>
            <div class="flex justify-center">
                <button type="submit" class="bg-slate-400 w-fit p-2 rounded-lg text-3xl text-slate-100">Submit</button>
            </div>
        </form>
    </div>
</cfsavecontent>

<!--- actually call the template --->
<cfinclude template="../layouts/baseLayout.cfm" >

