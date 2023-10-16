component {
    property name="username" type="string" getter="true" setter="true" ;
    property name="hashedPassword" type="string" getter="true" setter="false";
    property name="salt" type="string" getter="false" setter="false" ;

    public function init(struct args){
        if (!structKeyExists(args, "username") OR Trim(args.username) == "") {
            throw(type="InvalidArgument", message="Username is required");
        } else {
            setUsername(args.username);
        }

        if (!structKeyExists(args, "password") OR Trim(args.password) == "") {
            throw(type="InvalidArgument", message="Password is required");
        } else {
            salt = generateSalt();
            hashedPassword = hashPassword(args.password, salt);
        }

        return this;
    }

    private function generateSalt(){
        return createUUID();
    }

    public function setUsername(required string username){
        variables.username = username;
    }

    public function hashPassword(required string password, required string salt){
        return hash(password & salt);
    }

    public function checkPassword(required string password){
        return hash(password) == hashedPassword;
    }
}