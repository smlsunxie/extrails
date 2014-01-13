<sec:ifNotLoggedIn>

  <li >
    <g:link controller="store" action="list">
      <g:message code="store.label" />
      <i>store</i>
    </g:link>
  </li>

</sec:ifNotLoggedIn>



<sec:ifAnyGranted roles="ROLE_CUSTOMER">
  <li class="single">
    <g:homeNav />
  </li>

</sec:ifAnyGranted>


<sec:ifAnyGranted roles="ROLE_CUSTOMER">


  <li class="dropdown">
    <g:link controller="part" action="index" class="dropdown-toggle" data-toggle="dropdown">
      <g:message code="part.label" />
      <i>part</i>
    </g:link>
 
    <ul class="dropdown-menu">
      <li>
        <g:link controller="part" action="index">
          <g:message code="part.index.label"/>
        </g:link>
      </li>
      <li>
        <g:link controller="part" action="create">
          <g:message code="part.create.label"/>
        </g:link>
      </li>
    </ul>
  </li>


</sec:ifAnyGranted>


<sec:ifAnyGranted roles="ROLE_MANERGER, ROLE_OPERATOR">
  <li class="dropdown">
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
