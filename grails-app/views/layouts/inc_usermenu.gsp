



	<sec:ifNotLoggedIn>
		<%--未登入--%>

		<li class="${controllerName=='login' && actionName=='auth' ?'active':''} single">
			<g:link controller="login" action="auth">
			   <g:message code="default.login.text" />
				<i>LOGIN</i>
			</g:link>
		</li>

	</sec:ifNotLoggedIn>
	<sec:ifLoggedIn>
		<sec:ifAnyGranted roles="ROLE_MANERGER,ROLE_OPERATOR">


			<li class="${controllerName=='part' && actionName=='portfolio' ? 'active':''} single">
				<g:link controller="part" action="portfolio">
					檢視維修項目
					<i>PART</i>
				</g:link>
			</li>

			<li class="${controllerName=='post' && actionName=='create' ? 'active':''} single">
				<g:link controller="post" action="create">
					建立文章
					<i>POST</i>
				</g:link>
			</li>


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
					<li>
						<g:link controller="summary" action="turnoverYearList">
							<g:message code="summary.turnover.label"/>
						</g:link>
					</li>

				</ul>
			</li>
		</sec:ifAnyGranted>

		<%--已登入--%>
		<li class="dropdown">
			<a class="dropdown-toggle" data-toggle="dropdown" href="#menu3">
				<g:displayUserName />
				<i>ID</i>
			</a>
 
			<ul class="dropdown-menu">
				<li>
					<g:link controller="part" action="list" params="[offset:0,max:10]">
						維修項目清單
					</g:link>
				</li>

				<li >
					<g:link controller="event" action="create">
						建立新的事件
					</g:link>
				</li>

				<li>
					<g:link controller="part" action="create">
						建立維修項目
					</g:link>
				</li>
				<li >
					<g:link controller="event" action="list" params="[offset:0,max:10]">
						事件清單
					</g:link>
				</li>
				<li>
					<g:link controller="post" action="list">
						<g:message code="post.list.label"/>
					</g:link>
				</li>
				<li >
					<g:link controller="product" action="list" params="[offset:0,max:10]">
						產品清單
					</g:link>
				</li>


				<sec:ifAnyGranted roles="ROLE_MANERGER">

					<li>
						<g:link controller="user" action='list'>
							<g:message code="user.maintain.label" />
						</g:link>
					</li>

					<li>
						<g:link controller="role" action='list'>
							<g:message code="role.maintain.label" />
						</g:link>
					</li>

					<li>
						<g:link controller="userRole" action='list'>
							<g:message code="userRole.maintain.label" />
						</g:link>
					</li>

					<li>
						<g:link controller="store" action='list'>
							<g:message code="store.maintain.label" />
						</g:link>
					</li>
			

			
				</sec:ifAnyGranted>

				<sec:ifNotSwitched>
					<li>
						<g:link uri="/j_spring_security_logout">
						  <%--登出--%>
						  <g:message code="default.logout.text" />
						</g:link>
					</li>
				</sec:ifNotSwitched>

		  </ul>
	  </li>
  </sec:ifLoggedIn>
