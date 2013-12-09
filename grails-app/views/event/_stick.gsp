                  <div class="col-sm-3 col-md-3">

                    <a class="block-stick-img">

                        <g:img uri="/attachment/show?name=${event.product.name}&file=${event.product.mainImage}"  class="img-thumbnail" />
   
                    </a>

                    <div class="${stickName}-stick stick event">

                      <p>
                        <g:link controller="event" action="show" id="${event?.id}">
                        ${event?.name}
                      </g:link> 
                      </p>

                      <p>
                        <i class="icon-screenshot"></i> 
                        產品編號：<g:link controller="product" action="show" id="${event?.product?.id}">
                        ${event.product.name.replace(event.product.name.substring(2,4),"**")}
                      </g:link> 
                      </p>
                      
                      <p>
                        <i class="icon-user"></i> 
                        維修人員：${event?.user}
                      </p>

                      <p>
                        <i class="icon-user"></i> 
                        維修店家：<g:link  url="/store/${event?.user.store.name}">
                        ${event?.user.store.title}
                      </g:link> 


                      </p>

%{--                       <p class="date">
                        <i class="icon-calendar"></i>
                        維修日期： <g:formatDate date="${event.lastUpdated}" type="date" style="MEDIUM" />
                      </p> --}%
                      
                      <sec:ifAnyGranted roles="ROLE_OPERATOR">
                        <p class="date">
                          <i class="icon-calendar"></i>
                          維修總額： ${event.totalPrice}
                        </p>
                      </sec:ifAnyGranted>


                      <sec:ifAnyGranted roles="ROLE_OPERATOR">
                        <g:link class="btn btn-primary" controller="event" action="pickPartAddDetail" id="${event?.id}">新增維修</g:link>

                        <g:render template="/event/statusChangeBtn" model="[event: event]" />

                      </sec:ifAnyGranted>

                    </div>
                    <sec:ifAnyGranted roles="ROLE_OPERATOR">
                      <div class="row stick_outside">
                        
                        <div class="col-sm-6 col-md-6">
                            <div class="input-group input-group-sm">
                              <span class="input-group-addon">已收</span>
                              <g:remoteField action="updateReceivedMoney" controller="event" id="${event.id}"
                                  name="receivedMoney" onSuccess="onSuccessFun(data)" value="${event?.receivedMoney.toString()}"  data-for="unreceiveMoney_${event.id}" class="form-control" />                    
                          </div>
                        </div>
                        <div class="col-sm-6 col-md-6">
                            <div class="input-group input-group-sm">
                              <span  class="input-group-addon">未收</span>
                              <input readonly value="${event?.totalPrice-event?.receivedMoney}"  type="text" id="unreceiveMoney_${event.id}"  data-initValue="${event?.totalPrice}"  class="form-control" />                                    
                          </div>
                        </div>

                      </div>

                    </sec:ifAnyGranted>

                  </div>
