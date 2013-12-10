<div class="input-group">
  <span class="input-group-addon">已收</span>
  <g:remoteField action="updateReceivedMoney" controller="event" id="${event.id}" name="receivedMoney" onSuccess="onUpdateReceivedMoneySuccess(data)" value="${event?.receivedMoney.toString()}" class="form-control" data-totalPrice="${event?.totalPrice}"  type="number" /> 
</div>
