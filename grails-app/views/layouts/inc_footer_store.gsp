


<div class="footer-top"></div>
<div class="footer-wrapper">
  <div class="container">
    <div class="row show-grid">
      <div class="col-sm-12 col-md-12">
        <div class="row show-grid">
          <div class="col-sm-4 col-md-4">

            <h4 class="center-title">地址</h4>
            <address class="address">
              <p>
                <i class="icon-map-marker icon-large"></i>
                ${store?.address}
              </p>

            </address>


          </div>

          <div class="col-sm-4 col-md-4 footer-center">
            <h4 class="center-title">聯絡我們</h4>
            <p><i class="icon-phone"></i>Phone: ${store?.telphone}</p>
            <p><i class="icon-mobile-phone icon-large"></i>mobile: ${store?.mobile}</p>
            <p><i class="icon-print"></i>Fax: ${store?.fax}</p>
            <p><i class="icon-envelope"></i>
              Mail:<a class="btn btn-inverse btn-mini" href="${store?.email}"> ${store?.email}</a></p>
          </div>

          <div class="col-sm-4 col-md-4 footer-right">
            <h4 class="center-title">連結</h4>
            <ul class="footer-navigate">
              <g:applyLayout name="inc_sysmenu" />
            </ul> 
          </div>
        </div>
      </div>
    </div>
  </div>
</div>


