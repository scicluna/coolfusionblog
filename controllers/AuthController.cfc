component {
    property name="user" type="User" getter="true" setter="true";
    property name="loggedIn" type="boolean" getter="true" setter="false" default="false";

    public function init(User newUser){
        setUser(newUser);
        return this
    }

    public function setUser(User newUser){
        user = newUser;
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
                    AND password = :password
                )
                ",
                {
                    username: user.getUsername(),
                    password: user.getHashedPassword()
                },
                {datasource: 'blog2'}
            )
            session.user = user;
            loggedIn = true;
            return true
        } catch (Any e){
            return false;
        }
    }

    public function logout(){
        structDelete(session,"user")
    }

    public function isLoggedIn(){
        return loggedIn
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
                username: user.getUsername()
            },
            {
                datasource: 'blog2'
            }
        )
        if (userExists.recordCount gt 0){
            return false;
        } else {
            try {
                newUser = queryExecute(
                    "
                    INSERT INTO
                    users (username, password)
                    VALUES (:username, :password)
                    ",
                    {
                        username: user.getUsername(),
                        password: user.getHashedPassword()
                    },
                    {
                        datasource: 'blog2'
                    }
                )
                session.user = user;
                loggedIn = true;
                return true;
            } catch(Any e){
                return false;
            }
        }
    }
}