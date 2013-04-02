                        <tr>
                            <td><g:link controller="eventDetail" action="list" params="[event:event.id]">${event.name}</g:link></td>
                            <td><g:message code="extrails.EventStatus.${event.status.name()}" /></td> 
                            <td>${event.mileage}</td> 
                            <td><g:formatDate date="${event.lastUpdated}" type="date" style="SHOROT" /></td>
                            <td>
                              
                              <g:if test="${event.status == extrails.EventStatus.END}">

                                <g:link
                                    class="btn btn-primary btn-mini"
                                    action="changeStatus"
                                    controller="event"
                                    id="${event.id}" 
                                    params="[status:extrails.EventStatus.UNFIN.name(), controllerName:controllerName]" >
                                  <g:message code="extrails.EventStatus.UNFIN" />
                                </g:link>

                              </g:if>
                              <g:else>

                                <g:link  
                                    class="btn btn-primary btn-mini"
                                    action="changeStatus"
                                    controller="event"
                                    id="${event.id}" 
                                    params="[status:extrails.EventStatus.END.name(), controllerName:controllerName]" >
                                  <g:message code="extrails.EventStatus.END" />
                                </g:link>

                              </g:else>

                              <g:link  
                                  class="btn btn-primary btn-mini"
                                  action="create"
                                  controller="eventDetail"
                                  params="[event:event.id]"  >
                                <g:message code="eventDetail.create" />
                                </g:link>

                            </td>
                        </tr>