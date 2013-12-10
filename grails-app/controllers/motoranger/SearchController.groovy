package motoranger
import grails.plugin.springsecurity.annotation.Secured
class SearchController {
	static layout="bootstrap"

    @Secured(['ROLE_OPERATOR'])
    def query(){

        def productSearchResult
        def userSearch

        params.max= 6

        if(params.q && params.q != ''){
            productSearchResult = Product.search('*'+params.q+'*',params)

        }



        if(productSearchResult?.results.size() == 1){
        	def product = productSearchResult?.results.get(0)
        	redirect(controller:"product", action:'show', id: product.id)
        }
        else {
        	render (view:"result", model:[searchResult:productSearchResult])
        }


    } 

}
