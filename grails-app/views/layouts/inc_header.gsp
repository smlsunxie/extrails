
<sec:ifNotLoggedIn>
    <div class="container">
        <div class="row">
    <!-- HEADER: LOGO AREA -->
            <div class="span4 logo">
                <a class="logo" href="index.html">
                    <g:img alt="logo" dir="images" file="logo.jpeg" />
                </a>
            </div>
            <div class="span4">
                <ul class="socials unstyled">

                    <li><a class="twitter" href="#"></a></li>
                    <li><a class="facebook" href="#"></a></li>

                </ul>
            </div>
            <div class="span4">
    <!-- HEADER: PHONE NUMBER -->
                <p class="head_phone"><a href="tel:02-2303-3926">(02) 2303-3926</a></p>
                <p class="head_phone"><a href="tel:0932343454">0932343454</a></p>

            </div>
    <!-- HEADER: SOCIAL ICONS -->


        </div>
    </div>
</sec:ifNotLoggedIn>

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
