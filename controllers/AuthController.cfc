component {
    property name="user" type="User" getter="true" setter="true";

    public function init(newUser){
        this.user = newUser;
        return this
    }

    public function login(){
        try{
            fetchedUser = queryExecute(
                "
                SELECT
                    *
                FROM
                    users
                WHERE (
                    username = :username
                )
                ",
                {
                    username: this.user.username
                },
                {datasource: 'blog2'}
            )
            if (fetchedUser.recordCount gt 0){
                salt = fetchedUser.salt;
                hashedPassword = hash(this.user.password & salt, "SHA-256")
                if (hashedPassword eq fetchedUser.password){
                    session.user = this.user;
                    session.loggedIn = true;
                    return true;
                } else {
                    return false;
                }
            } 
        } catch (Any e){
            writeDump(e)
            return false;
        }
    }

    public function logout(){
        structDelete(session,"user")
        structDelete(session,"loggedIn")
    }

    public function isLoggedIn(){
        return session.loggedIn
    }

    public function register(){
        userExists = queryExecute(
            "
            SELECT 
            *
            FROM
            users
            WHERE
            username = :username
            ",
            {
                username: this.user.username
            },
            {
                datasource: 'blog2'
            }
        )
        if (userExists.recordCount gt 0){
            return false;
        } else {
            try {
                salt = createUUID();
                hashedPassword = hash(this.user.password & salt, "SHA-256")
                registerUser = queryExecute(
                    "
                    INSERT INTO
                    users (username, password, created_at, salt)
                    VALUES (:username, :password, now(), :salt)
                    ",
                    {
                        username: this.user.username,
                        password: hashedPassword,
                        salt: salt
                    },
                    {
                        datasource: 'blog2'
                    }
                )
                session.user = this.user;
                session.loggedIn = true;
                return true;
            } catch(Any e){
                writeDump(e)
                return false;
            }
        }
    }

    public function authPost(postId){
        checkPost = queryExecute(
            "
            SELECT
            id
            FROM
            posts
            WHERE
            id = :id
            AND
            user_id = :user_id
            ",
            {
                id: postId,
                user_id: session.user.getUserId()
            },
            {
                datasource: 'blog2'
            }
        )
        return checkPost.recordCount gt 0;
    }
}