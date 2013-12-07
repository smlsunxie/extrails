
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="bootstrap">
<title>${product?.title}</title>
</head>
<body>

  <sec:ifAllGranted roles="ROLE_OPERATOR">
    <g:actionbar domain="${product}" />
  </sec:ifAllGranted>

                      

  <g:render template="productContent" />


  <div class="contact-info" >
    <h2>維修記錄</h2>

    <g:each in="${product.events}" var="event" status="i">
      <div class="row">
        <div class="contact-info col-sm-6 col-md-6">  
          <table class="table">
            <tbody>
              <tr>
                  <td class="small"><g:message code="event.name.label" /></td>
                  <td class="bold">
                    <g:link controller="event" action="show">${event.name}</g:link>
                  </td>
              </tr>
              <tr>
                  <td class="small"><g:message code="default.dateCreated.label" /></td>
                  <td class="bold">
                    <g:formatDate date="${event.date}" type="date" style="SHOROT" />
                  </td>
              </tr> 
              <tr>
                  <td class="small"><g:message code="user.title.label" /></td>
                  <td class="bold">${event?.user}</td>
              </tr> 
              <tr>
                  <td class="small"><g:message code="event.mileage.label" /></td>
                  <td class="bold">${event.mileage}</td>
              </tr> 
              <tr>
                  <td class="small"><g:message code="event.store.label" /></td>
                  <td class="bold">${event.store}</td>
              </tr> 
            </tbody>
          </table>
        </div>

        <div class="contact-info col-sm-6 col-md-6">  
          <table class="table" id="no-more-tables">
            <thead>
              <tr>
                <th><g:message code="part.label" /></th>
                <th><g:message code="part.price.label" /></th>
              </tr>
            </thead>

            <g:each in="${event.details}" var="detail" status="j">
              <tbody>        
                
                  <tr>
                    <td data-title='<g:message code="part.label" />'>${detail?.part?.title}</td>
                    <td data-title='<g:message code="part.price.label" />'>${detail?.part?.price}</td>
                  </tr>
                
                
              </tbody>
            </g:each>


          </table> 
        </div>
      </div>
    </g:each>

  </div>

</body>
</html>
