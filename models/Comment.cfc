component{
    property User author;
    property string postId;
    property string content;

    public function init(User author, string postId, string content){
        setUser(author);
        setPostId(postId);
        setContent(content);
    }
    
    function setUser(User newAuthor){
        author = newAuthor;
    }

    function setPostId(string newPostId){
        postId = newPostId;
    }

    function setContent(string newContent){
        content = newContent;
    }

    function getUser(){
        return author;
    }

    function getPostId(){
        return postId;
    }

    function getContent(){
        return content;
    }
}