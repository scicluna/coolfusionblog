component {
    property name="username" type="string" getter="true" setter="true" ;
    property name="password" type="string" getter="true" setter="false";

    public function init(struct args){
        if (!structKeyExists(args, "username") OR Trim(args.username) == "") {
            throw(type="InvalidArgument", message="Username is required");
        } else {
            this.username = args.username
        }

        if (!structKeyExists(args, "password") OR Trim(args.password) == "") {
            throw(type="InvalidArgument", message="Password is required");
        } else {
            this.password = args.password
        }
        return this;
    }
    
    public function getUserId(){
        userId = queryExecute(
            "
            SELECT id
            FROM users
            WHERE username = :username   
            ",
            {username: this.username},
            {datasource: 'blog2'}
        );
        return userId;
    }
}