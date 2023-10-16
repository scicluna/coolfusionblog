component{
    property name="author" type="User" getter="true" setter="true";
    property name="postId" type="string" getter="true" setter="true";
    property name="content" type="string" getter="true" setter="true";

    public function init(struct args){
        if (!structKeyExists(args,"content")){
            throw(type="InvalidArgument", message="Content is required");
        }

        structAppend(variables,args)
        return this;
    }
}