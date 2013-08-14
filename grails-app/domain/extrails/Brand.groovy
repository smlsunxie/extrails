package extrails

public enum BrandType {
    MOTOCYCLE,CAR,OTHERS
}

class Brand {
	String name
	String title
	String description=""
	String homepage=""
	BrandType type=BrandType.OTHERS

    static constraints = {
    	name unique: true
    }

    public String toString(){
    	return title
    }
}
