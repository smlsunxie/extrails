<!DOCTYPE html>
<html>
	<head>
		<title><g:message code="default.home.label"/></title>

	</head>
	<body>
            <sec:ifNotLoggedIn>
            			<div class="bannercontainer" >

                            <div class="flexslider slider1">
                              <ul class="slides">
                                  <li class="slide4">
                                      <img alt="" src="http://4.bp.blogspot.com/-qkBOxhKvsu4/UGqp2TSiLSI/AAAAAAAAAC8/EWBp1UoXzaw/s1600/P1000578.jpg" />
                                      <div class="carousel-caption">
                                          <h2><a href="#">勝祥機車行</a></h2>
                                          <h3>機車維修與二手機車拍賣
                                          <br>Taiwan Motorcycle Maintenance and used motorbike trading</h3>
                                      </div>
                                  </li>

                              </ul>
                            </div>

              	   </div>
            </sec:ifNotLoggedIn>




            <sec:ifAnyGranted roles="ROLE_MANERGER">

              <div class="main-block block-posts">

                  <div class="row show-grid clear-both">
                      <div class="span12">

                        <div class="row show-grid">

                          <g:each var='operator' in='${operators}' >
                            <div class="span3">
                              <p>
                                <g:link class="btn btn-primary" url="${request.contextPath}/j_spring_security_switch_user?j_username=${operator.username}">${operator.title}</g:link>                              
                              </p>
                            </div>
                          </g:each>
                        </div>

                      </div>
                  </div>
              </div>
              <hr>
            </sec:ifAnyGranted>



            <div class="main-block block-posts">
              <div class="title-wrapper">
                  <h1><i class="icon-signin"></i> 維修中</h1>
              </div>
                <div class="row show-grid clear-both">
                    <div class="span12">
                      <div class="row show-grid">


                        <g:each var='event' in='${unfinEvents}' >
                          <div class="span3">

                            <a class="block-stick-img">
                              <g:if test="${event?.product?.mainImage && event?.product?.mainImage!=''}">
                                <g:img uri="attachment/show?name=${event.product.name}&file=${event.product.mainImage}"  class="bordered-img" />
                              </g:if> 
                              <g:else>
                                <g:img dir="images" file="notFind.jpg" class="bordered-img" />
                              </g:else>
                            </a>

                            <div class="alert-stick stick event">

                              <p><i class="icon-screenshot"></i> 產品編號：${event.product.name.replace(event.product.name.substring(2,4),"**")}</p>
                              <p><i class="icon-user"></i> 維修人員：${event.user.title}</p>
                              <p class="date"><i class="icon-calendar"></i>維修日期： <g:formatDate date="${event.lastUpdated}" type="date" style="MEDIUM" /></p>
                              <sec:ifAnyGranted roles="ROLE_OPERATOR"><p class="date"><i class="icon-calendar"></i>維修總額： ${event.totalPrice}</p></sec:ifAnyGranted>
                            
                              <g:link class="btn btn-primary" controller="event" action="list" params="[event:event?.id]">維修記錄</g:link>

                              <sec:ifAnyGranted roles="ROLE_OPERATOR">
                                <g:link class="btn btn-primary" controller="event" action="create" params="[event:event?.id]">新增維修</g:link>

                                <g:if test="${event?.product?.status.name() == "UNFIN"}"> 
                                  <g:link class="btn btn-primary" action="changeStatus" id="${event?.id}" controller="event" params="[status:extrails.ProductStatus.END.name(),controllerName:controllerName]">維修結束</g:link>
                                </g:if>

                                <g:link controller="product" action="show" id="${event?.product?.id}" class="btn btn-primary">
                                  產品資料
                                </g:link>

                              </sec:ifAnyGranted>

                            </div>
                            <sec:ifAnyGranted roles="ROLE_OPERATOR">
                              <div class="row-fluid stick_outside">
                                
                                <div class="span6">
                                    <div class="input-prepend input-append">
                                      <span class="add-on">已收</span>
                                      <g:remoteField action="updateReceivedMoney" controller="event" id="${event.id}"
                                          name="receivedMoney" onSuccess="onSuccessFun(data)" value="${event?.receivedMoney.toString()}"  data-for="unreceiveMoney_${event.id}" class="span6" />                                    
                                  </div>
                                </div>
                                <div class="span6">
                                    <div class="input-prepend input-append">
                                      <span  class="add-on">未收</span>
                                      <input readonly value="${event?.totalPrice-event?.receivedMoney}"  type="text" id="unreceiveMoney_${event.id}"  data-initValue="${event?.totalPrice}"  class="span6" />                                    
                                  </div>
                                </div>

                              </div>
  
                            </sec:ifAnyGranted>

                          </div>
                        </g:each>




                      </div>
                    </div>
                </div>
            </div>
            
            <hr>
            <div class="main-block block-posts">
              <div class="title-wrapper">
                  <h1><i class="icon-ok "></i> 維修完成</h1>
              </div>
              <div class="row show-grid clear-both">
                <div class="span12">
                  <div class="row show-grid">
                    <g:each var='event' in='${endEvents}' >
                      <div class="span3">


                        <a class="block-stick-img">
                          <g:if test="${event?.product?.mainImage && event?.product?.mainImage!=''}">
                            <g:img uri="attachment/show?name=${event.product.name}&file=${event.product.mainImage}"  class="bordered-img" />
                          </g:if> 
                          <g:else>
                            <g:img dir="images" file="notFind.jpg" class="bordered-img" />
                          </g:else>
                        </a>

                        <div class="success-stick stick event">


                          <p><i class="icon-screenshot"></i> 產品編號：${event.product.name.replace(event.product.name.substring(2,4),"**")}</p>
                          <p><i class="icon-user"></i> 維修人員：${event.user.title}</p>
                          <p class="date"><i class="icon-calendar"></i>維修日期： <g:formatDate date="${event.lastUpdated}" type="date" style="MEDIUM" /></p>
                          <sec:ifAnyGranted roles="ROLE_OPERATOR"><p class="date"><i class="icon-calendar"></i>維修總額： ${event.totalPrice}</p></sec:ifAnyGranted>

                          <g:link class="btn btn-primary" controller="event" action="list" params="[event:event?.id]">維修記錄</g:link>

                          <sec:ifAnyGranted roles="ROLE_MANERGER,ROLE_OPERATOR">
                            <g:link class="btn btn-primary" controller="event" action="create" params="[event:event.id]">新增維修</g:link>
                            
                            <g:link controller="product" action="show" id="${event?.product?.id}" class="btn btn-primary">
                              產品資料
                            </g:link>
                          </sec:ifAnyGranted>  

                        </div>
                        <sec:ifAnyGranted roles="ROLE_OPERATOR">
                          <div class="row-fluid stick_outside">
                            
                            <div class="span6">
                                <div class="input-prepend input-append">
                                  <span class="add-on">已收</span>
                                  <g:remoteField action="updateReceivedMoney" controller="event" id="${event.id}"
                                      name="receivedMoney" onSuccess="onSuccessFun(data)" value="${event?.receivedMoney.toString()}"  data-for="unreceiveMoney_${event.id}" class="span6" />                                    
                              </div>
                            </div>
                            <div class="span6">
                                <div class="input-prepend input-append">
                                  <span  class="add-on">未收</span>
                                  <input readonly value="${event?.totalPrice-event?.receivedMoney}"  type="text" id="unreceiveMoney_${event.id}"  data-initValue="${event?.totalPrice}"  class="span6" />                                    
                              </div>
                            </div>

                          </div>

                        </sec:ifAnyGranted>
                      </div>




                    </g:each>
                  </div>
                </div>
              </div>
            </div>


            <hr>
 %{--            <div class="main-block block-posts">
                <div class="title-wrapper">
                    <h1>最近建立產品</h1>
                </div>
                <div class="row show-grid clear-both">
                    <div class="span12">
                      <div class="row show-grid">
                        <g:each var='product' in='${createProducts}' >
                          <div class="span3">

                            <g:if test="${product?.mainImage}">
                              <a class="block-post-img">
                                <g:img uri="attachment/show?name=${product.name}&file=${product.mainImage}"  class="img-rounded" />
                              </a>
                            </g:if>  

                            <p>產品編號：${product.name}</p>
                            <p>產品名稱：${product.title}</p>
                            <p>里程數：${product.mileage}</p>
                            <p class="date"><i class="icon-calendar"></i><g:formatDate date="${product.lastUpdated}" type="date" style="MEDIUM" /></p>

                            
                              <p>
                                <g:link class="btn btn-primary btn-large" controller="event" action="list" params="[product:product?.id]">維修記錄</g:link>

                                <sec:ifAnyGranted roles="ROLE_MANERGER,ROLE_OPERATOR">
                                  <g:link class="btn btn-primary btn-large" controller="event" action="create" params="[product:product?.id]">新增維修</g:link>
                                  <g:link controller="product" action="show" id="${product?.id}" class="btn btn-primary btn-large">
                                    產品資料
                                  </g:link>
                                </sec:ifAnyGranted>

                              
                              </p>

                            

                          </div>
                        </g:each>
                      </div>
                    </div>
                </div>
            </div>
            
            <hr> --}%
            <div class="row main-block">
                <div class="span12">
                    <div class="row">
<!-- MAIN CONTENT AREA: REDESIGN CUSTOM - HERO BLOCK 1 (TEXT BLOCK)] -->
                        <div class="span12 home-block hero-block-1">
                            <h1>歡迎您的光臨</h1>
                            <h2>為您的愛車提供最優質的服務</h2>
                            <h3>開店已有 30 餘年，請相信我們的專業，誠摯為您服務，各種廠牌二手車輛買賣與維修，非一般大賣場勉強整理的機車，品質與車況有保障</h3>
                        </div>
<!-- MAIN CONTENT AREA: SPACER BETWEEN HERO BLOCK 1 AND HEREO BLOCK 2 -->
                        <div class="span1">
                        </div>
<!-- MAIN CONTENT AREA: bizstrap CUSTOM - HERO BLOCK 2 -->
%{--                         <div class="span5 home-block">
                            <div class="grey-box hero-block-2">
                                <h2><a href="#">優惠消息！</a></h2>
                                <p><g:img alt="logo" dir="img" file="release_icon.png" />
                                		什麼東西正在優惠勒？
                                </p>
                                <a href="#" class="btn btn-warning"><i class="icon-shopping-cart"></i>現在買只要  $$$$</a>
                            </div>
                        </div>
 --}%                    </div>
                </div>
            </div>
            <hr>
            <div class="row main-block">
                <div class="span12">
<!-- MAIN CONTENT AREA: bizstrap CUSTOM - HERO LIST -->
                    <div class="row show-grid hero-list">
%{--                         <div class="span3">
                            <div class="image-wrapper">
                                <img alt="" src="img/ruler.png" />
                            </div>
                            <h2>DIY 維修區</h2>
                            <p>每天只要 $$ 元，提供您各種維修器具，讓你可以自行維修您的愛車，在維修問題上，有專業技師作為您維修的顧問！
                            </p>
                        </div> --}%

                        <div class="span3">
                            <div class="image-wrapper">
                                <img alt="" src="img/direction.png" />
                            </div>
                            <h2>快速保養與救車</h2>
                            <p>趕時間出門嘛？愛車拋錨在路邊？別擔心，歡迎來電求救！
                                %{-- <a href="#">Learn more&nbsp;&raquo;</a> --}%
                            </p>
                        </div>
                        <div class="span3">
                            <div class="image-wrapper">
                                <img alt="" src="img/both_arrows.png" />
                            </div>
                            <h2>二手銷售</h2>
                            <p>擁有最優質的二手機車，實惠的價格，來自中南部台灣好天氣下的二手機車喔！
                                %{-- <a href="#">Learn more&nbsp;&raquo;</a> --}%
                            </p>
                        </div>
                        <div class="span6">
                            <div class="image-wrapper">
                                <img alt="" src="img/equaliser.png" />
                            </div>
                            <h2>專業工具</h2>
                            <p>我們擁有拆胎機，在更換輪胎時愛護您的輪框；還有機油槍，為您的引擎注入最合適的容量，以及輪胎氣壓計，為您注入最合適的胎壓
                                %{-- <a href="#">Learn more&nbsp;&raquo;</a> --}%
                            </p>
                        </div>
                    </div>
                </div>
                <div class="horizontal-divider span12"></div>
            </div>
            <hr>
            <div class="row show-grid">
              <div class="span12 grey-box">
                  <div class="hero-block3">
                      <div class="row show-grid">
                          <div class="span9">
                              <div class="hero-content-3">
                                  <h2>English it's OK! 日本語もできます！</h2>
                              </div>
                          </div>
%{--                           <div class="span3">
                              <div class="tour-btn">
                                  <a href="#" class="btn btn-warning">come Here!</a>
                              </div>
                          </div> --}%
                      </div>
                  </div>
              </div>
            </div>
            <hr>
            <div class="main-block block-posts">
                <div class="title-wrapper">
                    <h2>最近的文章</h2><a href="#" class="all"></a>
                </div>
                <div class="row show-grid clear-both">
                    <div class="span12">
                      <div class="row show-grid">
                        <g:each var='recentPost' in='${recentPosts}' >
                          <div class="span3">
                            <a class="block-post-img" href="#">

  
                              <g:render template="/post/mainImg" model="[post:recentPost]" />

                            </a>
                            <g:link controller='post' action='show' id='${recentPost.id}' class="block-post-title">${recentPost.title}</g:link>
                            <p class="block-post-date"><g:formatDate date='${recentPost.lastUpdated}' type='date' style='MEDIUM' /></p>
                            <p class="block-post-content">${recentPost.description}</p>
                            <g:link controller='post' action='show' id='${recentPost.id}' class="block-post-more">Read more&nbsp;&raquo;</g:link>
                          </div>
                        </g:each>
                      </div>
                    </div>
                </div>
            </div>
            <hr>


            <div class="main-block clients">
                <div class="title-wrapper">
                    <h2>服務廠牌</h2>
                </div>
                <div class="row show-grid">
                    <div class="span12">
                        <div id="clients" class="row show-grid">
                            <div class="span2 clear-both hp-wrapper">
                                <g:img alt="" dir="images" file="yamaha.jpg" />
                            </div>
                            <div class="span2 hp-wrapper">
                                <g:img alt="" dir="images" file="sym.jpg" />
                            </div>
                            <div class="span2 hp-wrapper">
                                <g:img alt="" dir="images" file="kymco.jpg" />
                            </div>
                            <div class="span2 hp-wrapper">
                                <g:img alt="" dir="images" file="suzuki.jpg" />
                            </div>
                            <div class="span2 hp-wrapper">

                            </div>
                            <div class="span2 hp-wrapper">
                                
                            </div>



                        </div>
                    </div>
                </div>
            </div>

	</body>
</html>
