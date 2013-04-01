                        <tr>
                            <td><g:link controller="serviceEventDetail" action="list" params="[serviceEvent:serviceEvent.id]">${serviceEvent.name}</g:link></td>
                            <td><g:message code="extrails.EventStatus.${serviceEvent.status.name()}" /></td> 
                            <td>${serviceEvent.mileage}</td> 
                            <td><g:formatDate date="${serviceEvent.lastUpdated}" type="date" style="SHOROT" /></td>
                            <td>
                              
                              <g:if test="${serviceEvent.status == extrails.EventStatus.END}">

                                <g:link
                                    class="btn btn-primary btn-mini"
                                    action="changeStatus"
                                    controller="serviceEvent"
                                    id="${serviceEvent.id}" 
                                    params="[status:extrails.EventStatus.UNFIN.name(), controllerName:controllerName]" >
                                  <g:message code="extrails.EventStatus.UNFIN" />
                                </g:link>

                              </g:if>
                              <g:else>

                                <g:link  
                                    class="btn btn-primary btn-mini"
                                    action="changeStatus"
                                    controller="serviceEvent"
                                    id="${serviceEvent.id}" 
                                    params="[status:extrails.EventStatus.END.name(), controllerName:controllerName]" >
                                  <g:message code="extrails.EventStatus.END" />
                                </g:link>

                              </g:else>

                              <g:link  
                                  class="btn btn-primary btn-mini"
                                  action="create"
                                  controller="serviceEventDetail"
                                  params="[serviceEvent:serviceEvent.id]"  >
                                <g:message code="serviceEventDetail.create" />
                                </g:link>

                            </td>
                        </tr>