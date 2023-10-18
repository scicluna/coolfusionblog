component {
    public function getPosts(){
        posts = queryExecute(
            "
            SELECT 
            * 
            FROM 
            posts
            ORDER BY
            date DESC;
            ",
            {},
            {datasource: "blog2"}
        )
        return posts;
    }

    public function getPostById(string id){
            post = queryExecute(
                "
                SELECT
                *
                FROM
                posts
                WHERE
                id = :id
                ",
                {id: id},
                {datasource: "blog2"}
            )
            return post;
    }

    public function createPost(Post post){
        try{
            queryExecute(
                "
                INSERT INTO
                posts (title, content, created_at, userid)
                VALUES (:title, :content, now(), :userid)
                ",
                {
                    title: post.getTitle(),
                    content: post.getContent(),
                    userid: post.author.getUserId()
                },
                {datasource: "blog2"}
            )
            return true;
        } catch(Any e) {
            throw(message="Error creating post");
        }
    }

    public function editPostById(string postId, Post post){
        try{
            queryExecute(
                "
                UPDATE
                posts
                SET
                title = :title,
                content = :content,
                created_at = now()
                WHERE
                id = :id
                ",
                {
                    title: post.getTitle(),
                    content: post.getContent(),
                    id: postId
                },
                {datasource: "blog2"}  
            )
            return true;
        } catch(Any e){
            throw(message="Error editing post");
        }
    }

    public function deletePostById(string id){
        try{
            queryExecute(
                "
                DELETE FROM
                posts
                WHERE
                id = :id
                ",
                {id: id},
                {datasource: "blog2"}
            )
            return true;
        } catch(Any e){
            throw(message="Error deleting post");
        }
    }

    public function createComment(string postId, Comment comment){
        try {
            queryExecute(
                "
                INSERT INTO
                comments (content, created_at, userid, postid)
                VALUES (:content, now(), :userid, :postid)
                ",
                {
                    content: comment.getContent(),
                    userid: comment.author.getUserId(),
                    postid: postId
                },
                {datasource: "blog2"}
            )
            return true;
        } catch(Any e){
            throw(message="Error creating comment");
        }
    }

    public function editComment(string postId, Comment comment){
        try {
            queryExecute(
                "
                UPDATE
                comments
                SET
                content = :content,
                created_at = now()
                WHERE
                id = :id
                ",
                {
                    content: comment.getContent(),
                    id: commentId
                },
                {datasource: "blog2"}
            )
            return true;
        } catch(Any e){
            throw(message="Error editing comment");
        }
    }

    public function deleteComment(string commentId){
        try {
            queryExecute(
                "
                DELETE FROM
                comments
                WHERE
                id = :id
                ",
                {id: commentId},
                {datasource: "blog2"}
            )
            return true;
        } catch(Any e){
            throw(message="Error deleting comment");
        }
    }
}