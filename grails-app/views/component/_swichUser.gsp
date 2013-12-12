        <li class="dropdown">
          <a class="dropdown-toggle" data-toggle="dropdown" href="#menu3">
            切換使用者
            <i>Switch</i>
          </a>

          <ul class="dropdown-menu">
            <g:each in="${operators}" var="operator">
              <li>
                <g:link url="${request.contextPath}/j_spring_security_switch_user?j_username=${operator.username}" >
                    ${operator?.title}
                </g:link>
              </li>

            </g:each>
          </ul>
        </li>