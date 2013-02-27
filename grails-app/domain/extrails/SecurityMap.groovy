package extrails
import org.apache.commons.lang.builder.HashCodeBuilder

class SecurityMap {

   String url
   String configAttribute

   static mapping = {
      cache true
   }

   static constraints = {
      url blank: false, unique: true
      configAttribute blank: false
   }
}