<g:set var="stickName" value="${event.status == motoranger.ProductStatus.UNFIN? 'alert' : 'success'}" />

<div class="row">
  <div id="eventStick" class="contact-info col-sm-3 col-md-3"> 

  	<g:render template="/event/stick" model="['event': event, 'stickName': stickName]" /> 
  
  </div>
  <div id="eventContentTable" class="contact-info col-sm-3 col-md-3"> 
  	<h2>&nbsp;</h2>
    <g:render template="/event/content" model="event:event" />
  </div>

  <div class="contact-info col-sm-6 col-md-6">  
    <g:render template="/eventDetail/contentWithDetails" model="event:event" />
  </div>
</div>