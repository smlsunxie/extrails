package extrails

public enum BrandType {
    MOTOCYCLE,CAR,OTHERS
}

class Brand {
	String name
	String title
	BrandType type=BrandType.OTHERS

    static constraints = {
    }
}
