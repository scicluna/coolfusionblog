component {
    public function getPosts(numeric currentPage, numeric PAGINATION){
        offset = (currentPage - 1) * PAGINATION;
        
        try{
            posts = queryExecute(
                "
                SELECT 
                * 
                FROM 
                posts
                ORDER BY created_at DESC
                LIMIT :offset, :PAGINATION 
                
                ",
                {
                    PAGINATION: { value=PAGINATION, cfsqltype="cf_sql_integer" },
                    offset: { value=offset, cfsqltype="cf_sql_integer" }
                },
                {datasource: "blog2"}
            )
            return posts;
        } catch(Any e){
            writeDump(e)
        }
    }

    public function getTotalPages(numeric recordsPerPage = 10) {
        totalRecords = queryExecute(
            "
            SELECT COUNT(*) 
            AS 
            count 
            FROM 
            posts;
            ",
            {},
            {datasource: "blog2"}
        ).count;

        return ceiling(totalRecords / recordsPerPage);
    }

    public function getPostById(numeric id){
            post = queryExecute(
                "
                SELECT
                *
                FROM
                posts
                WHERE
                id = :id
                ",
                {id: { value=id, cfsqltype="cf_sql_integer" }},
                {datasource: "blog2"}
            )
            return post;
    }

    public function createPost(Post post){
        writeDump(post.author.getUserId())
        postToCreate = queryExecute(
            "
            INSERT INTO
            posts (category, title, content, created_at, user_id)
            VALUES (:category, :title, :content, now(), :user_id)
            ",
            {
                category: post.category,
                title: post.title,
                content: post.content,
                user_id: post.author.getUserId()
            },
            {datasource: "blog2"}
        )
        return true;
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
                    title: post.title,
                    content: post.content,
                    id: postId
                },
                {datasource: "blog2"}  
            )
            return true;
        } catch(Any e){
            writeDump(e);
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
                comments (content, created_at, user_id, postid)
                VALUES (:content, now(), :user_id, :postid)
                ",
                {
                    content: comment.getContent(),
                    user_id: comment.author.getUserId(),
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