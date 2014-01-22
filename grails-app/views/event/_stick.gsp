

<div class="${stickName}-stick stick event">

  <p>
    <g:link controller="event" action="show" id="${event?.id}">
    ${event?.name}
  </g:link> 
  </p>

  <sec:ifNotLoggedIn>
    <p>
      <i class="icon-screenshot"></i> 
      產品編號：<g:link controller="product" action="show" id="${event?.product?.id}">
      ${event.product.name.replace(event.product.name.substring(2,4),"**")}
    </g:link> 
    </p>
  </sec:ifNotLoggedIn>
  <sec:ifAnyGranted roles="ROLE_CUSTOMER">
    <p>
      <i class="icon-screenshot"></i> 
      產品編號：<g:link controller="product" action="show" id="${event?.product?.id}">
      ${params?.currentUserStoreId || params?.currentUserId == event?.user.id.toString() ? event.product.name : event.product.name.replace(event.product.name.substring(2,4),"**")}
    </g:link> 
    </p>  
  </sec:ifAnyGranted>
  


  <sec:ifAnyGranted roles="ROLE_OPERATOR">
    <p>
      <i class="icon-user"></i>
      維修人員：
      <g:link controller="user" action="show" id="${event?.user.id}" > 
        ${event?.user}
      </g:link>
    </p>
  </sec:ifAnyGranted>


  
  <sec:ifAnyGranted roles="ROLE_OPERATOR">
    <p>
      <i class="icon-user"></i>
      客戶名稱：
      <g:link controller="user" action="show" id="${event?.product?.user?.id}" > 
        ${event?.product?.user}
      </g:link>
    </p>  
    <p class="date">
      <i class="icon-calendar"></i>
      維修總額： ${event.totalPrice}
    </p>
  </sec:ifAnyGranted>

  <g:if test="${params?.currentUserStoreId == event?.store?.id || params?.currentUserId == event?.user?.id}">


    <sec:ifAnyGranted roles="ROLE_CUSTOMER">
      <g:if test="${actionName != 'pickPartAddDetail'}" >
        <g:link class="btn btn-primary" controller="event" action="pickPartAddDetail" id="${event?.id}">新增維修</g:link>

      </g:if>

      <g:render template="/event/statusChangeBtn" model="[event: event]" />

    </sec:ifAnyGranted>

  </g:if>
</div>

