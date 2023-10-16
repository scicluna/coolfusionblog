component {
    property name="author" type="User" getter="true" setter="true";
    property name="title" type="string" getter="true" setter="true";
    property name="content" type="string" getter="true" setter="true";
    property name="category" type="string" getter="true" setter="true"; 

    public function init(struct args){
        if (!structKeyExists(args, "title") OR Trim(args.title) == "") {
            throw(type="InvalidArgument", message="Title is required");
        }

        if (!structKeyExists(args, "content") OR Trim(args.content) == "") {
            throw(type="InvalidArgument", message="Content is required");
        }

        structAppend(variables, args);
        return this;
    }
}