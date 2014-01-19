<div id="productStick" class="col-sm-6 col-md-3">

  <a class="block-stick-img">

      <g:img uri="/attachment/show?name=${event.product.name}&file=${event.product.mainImage}"  class="img-thumbnail" />

  </a>

  <g:render template="/event/stick" model="['event': event, 'stickName': stickName]" />
  
  <sec:ifAnyGranted roles="ROLE_OPERATOR">
    <div class="row stick_outside">

      <div class="col-sm-10 col-md-10 col-md-offset-1 col-sm-offset-1">
        <g:render template="/event/updateReceivedMoney" model="[event: event]" />

        <g:render template="/event/updateUnreceiveMoney" model="[event: event]" />
      </div>


    </div>

  </sec:ifAnyGranted>

</div>
