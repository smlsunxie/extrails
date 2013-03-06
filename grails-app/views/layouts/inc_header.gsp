%{-- 	<div class="navbar-inner">
		<div class="container-fluid">
			<a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</a>
			<div class="nav-collapse collapse">
				<g:applyLayout name="inc_sysmenu" />
				<%--使用者選單--%>
				<g:applyLayout name="inc_usermenu" />
			</div><%--/.nav-collapse --%>
		</div>
	</div> --}%


            <div class="container">
                <div class="row">
<!-- HEADER: LOGO AREA -->
                    <div class="span4 logo">
                        <a class="logo" href="index.html">
                            <g:img alt="logo" dir="images" file="logo.jpeg" />
                        </a>
                    </div>
                    <div class="span4 offset4">
<!-- HEADER: PHONE NUMBER -->
                        <p class="head_phone"><a href="tel:02-2303-3926">(02) 2303-3926</a></p>
                    </div>
<!-- HEADER: SOCIAL ICONS -->
                    <ul class="socials unstyled">
                        <li><a class="twitter" href="#"></a></li>
                        <li><a class="facebook" href="#"></a></li>

                    </ul>

                </div>
            </div>


<!-- HEADER: PRIMARY SITE NAVIGATION -->
            <div class="container">
                <div class="navbar">
                    <div class="navbar-inner">
                        <div class="container">
                            <div class="buttons-container">

                            </div>

                            <div class="nav-collapse">
                                <ul class="nav nav-pills ">
                                	<g:applyLayout name="inc_sysmenu" />
                                </ul>
                                <ul class="nav nav-pills pull-right">
                                	<g:applyLayout name="inc_usermenu" />
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
