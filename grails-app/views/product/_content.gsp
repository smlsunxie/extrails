                  <h1>${product.title}</h1>
                  <div class="flexslider slider1">
                    <ul class="slides">
                      <g:each in="${files}" var="file" status="i">
            
                        <li class="slide4">
                            <img alt="" src="/attachment/show?name=${product.name}&file=${file.name}" />
                            <div class="carousel-caption">
                                <h2><a href="#">${file.name}</a></h2>
                                <p></p>
                            </div>
                        </li>

                      </g:each>  
                    </ul>
                  </div>  
                  
                  <h4>${product.description}</h4>  
                  
                  <hr>

                  <table class="table">

                      <tbody>
                            <sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_MANERGER">
                               <tr>
                                    <td><g:message code="product.cost.label" /></td>
                                    <td>${product.cost}</td>
                                </tr>   
                              </sec:ifAnyGranted>     
                             <tr>
                                  <td><g:message code="product.price.label" /></td>
                                  <td>${product.price}</td>
                              </tr> 

                      </tbody>
                  </table>