<div class="input-group">
  <span class="input-group-addon">未收</span>
  <g:remoteField action="updateDiscountMoney" controller="event" id="${event.id}" name="unreceiveMoney" onSuccess="onUpdateUnreciveMoneyMoneySuccess(data)" value="${(event?.totalPrice-event?.receivedMoney-event?.discountMoney).toString()}" class="form-control" type="number" data-totalPrice="${event?.totalPrice}"  />
</div>
