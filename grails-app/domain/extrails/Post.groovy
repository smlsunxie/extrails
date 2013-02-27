package extrails

public enum PostType {
    STATIC,
    ANNOUNCE;
}

class Post {

	String name
	String title
	String content
	// PostType type
	// String tag
	
	User creator		//建立者

    Date dateCreated    //建立日期
    Date lastUpdated    //修改日期
    
    int hits = 0        //點擊次數

    static constraints = {
    	name blank: false, unique: true
	    title blank: false
    	content nullable: true, empty: true, maxSize: 128*1024
    	
    }
}
