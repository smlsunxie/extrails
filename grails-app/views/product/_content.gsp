                  <h1>${product.title}</h1>
       
                    <g:render template="/component/slider" model="[files:files,name:product.name]"/>
                  <h4>${product.description}</h4>  
                  
                  <hr>

                  <g:render template="record" model="[product:product]"/>