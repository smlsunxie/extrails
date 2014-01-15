<sec:ifNotLoggedIn>

  <li class="${controllerName=='store' && actionName=='list' ? 'active':''}">
    <g:link controller="store" action="list">
      <g:message code="store.label" />
      <i>store</i>
    </g:link>
  </li>

</sec:ifNotLoggedIn>



<sec:ifAnyGranted roles="ROLE_CUSTOMER">
  
  <sec:ifAnyGranted roles="ROLE_CUSTOMER">
  <li class="${controllerName=='user' && actionName=='show' ? 'active':''} single">
    <g:homeNav />
  </li>
  </sec:ifAnyGranted>

  <li class="${controllerName=='part' ? 'active':''} single">
    <g:link controller="part" action="index">
      <g:message code="part.label" />
      <i>store</i>
    </g:link>
  </li>

</sec:ifAnyGranted>


<sec:ifAnyGranted roles="ROLE_MANERGER, ROLE_OPERATOR">
  <li class="${controllerName=='summary' ? 'active':''} dropdown">
    <a class="dropdown-toggle" data-toggle="dropdown" href="#menu2">
      <g:message code="summary.label"/>
      <i>SUMMARY</i>
    </a>
 
    <ul class="dropdown-menu">

      <li>
        <g:link controller="summary" action="unreceiveMoneyList">
          <g:message code="summary.unreceiveMoney.label"/>
        </g:link>
      </li>

      <sec:ifAnyGranted roles="ROLE_MANERGER">
        <li>
          <g:link controller="summary" action="turnoverYearList">
            <g:message code="summary.turnover.label"/>
          </g:link>
        </li>
      </sec:ifAnyGranted>
      
    </ul>
  </li>
</sec:ifAnyGranted>


<sec:ifAnyGranted roles="ROLE_ADMIN">
  
  <li>
    <g:link controller="brand">
      <g:message code="brand.label" />
      <i>brand</i>
    </g:link>
  </li>

  <li>
    <g:link controller="user" action="list">
      <g:message code="user.label" />
      <i>user</i>
    </g:link>
  </li>

  <li class="${controllerName=='post' && actionName=='create' ? 'active':''} single">
    <g:link controller="post" action="portfolio">
      文章
      <i>POST</i>
    </g:link>
  </li>

</sec:ifAnyGranted>


