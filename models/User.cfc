component {
    property username string;
    property password string;

    public function init(string username, string password){
        setUserName(username);
        setPassword(password);
        return this;
    }
	function setUserName (string newUsername){
        username = newUsername;
    }

	function setPassword (string newPassword){
        password = newPassword;
	}

    function getUserName (){
        return username;
    }

    function getPassword (){
        return password;
    }
}