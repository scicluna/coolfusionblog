component {
    property User author;
    property string title;
    property string content;
    property string category;

    public function init(User author, string title, string content, string category){
        setAuthor(author);
        setTitle(title);
        setContent(content);
        setCategory(category);
        return this;
    }
    
	function setCategory (string newCategory){
        category = newCategory;
	}

	function setContent (string newContent){
        content = newContent;
	}

	function setTitle (string newTitle){
        title = newTitle;
	}

	function setAuthor (User newAuthor){
        author = newAuthor;
	}

    function getCategory(){
        return category;
    }

    function getContent(){
        return content;
    }

    function getTitle(){
        return title;
    }

    function getAuthor(){
        return author;
    }


}