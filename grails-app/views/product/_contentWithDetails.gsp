<g:set var="s3Service" bean="s3Service"/>
<div class="row">

  <div class="contact-info col-sm-4 col-md-4">
    <h2>外觀</h2>
    <g:render template="/component/slider" model='[files: s3Service.getObjectList("${grailsApplication.config.grails.aws.root}/${product.name}"), name: product.name]'/>
  </div>
  <div class="contact-info col-sm-4 col-md-4">
    <h2>產品資料</h2>
    <g:render template="/product/content" model="[product: product]" />
  </div>
  <div class="contact-info col-sm-4 col-md-4">
    <h2>車主資料</h2>
    
    <g:if test="${!product.user}">
      <div class="text-center">
        <g:link  class="btn btn-primary" controller="user" action="create" params="['product.id':product?.id]">
          <g:message code="product.user.create.label" />
        </g:link>
      </div>
    </g:if>
    <g:else>
      <g:render template="/user/content" model="[user: product.user, product: product]" />
    </g:else>
  </div>
</div>