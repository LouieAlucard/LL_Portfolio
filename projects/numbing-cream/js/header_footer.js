$( document ).ready(function() {
    var header = document.getElementById("topNav");
    header.innerHTML = ''+
    	'<nav class="navbar navbar-default numbing">'+
		  	'<div class="container-fluid">'+
			    '<div class="navbar-header">'+
			      	'<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">'+
			        '<span class="sr-only">Toggle navigation</span>'+
			        '<span class="icon-bar"></span>'+
			        '<span class="icon-bar"></span>'+
			        '<span class="icon-bar"></span>'+
			      	'</button>'+
			      	'<a class="navbar-brand" href="#">'+
			      		'<img class="bioevolve-brand" src="img/bioevolve_logo.png" alt="BioZkin Brand">'+
			      	'</a>'+
			      	'<div class="nav-icons">'+
			      		'<a href="#">'+
			      			'<img class="icon" src="img/icon_cart.png" id="iconCart" alt="shopping cart icon">'+
			      		'</a>'+

		              	'<li class="dropdown no-bullet" id="userBtn">'+
                			'<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">'+
                				'<img class="icon" src="img/icon_user.png" alt="user icon">'+
                				'<span class="text">Username</span> '+
                				'<span class="caret"></span>'+
                			'</a>'+
                			'<ul class="dropdown-menu">'+
                				'<li><a href="#">my account</a></li>'+
							    '<li><a href="#">order history</a></li>'+
							    '<li><a href="#">log out</a></li>'+
                			'</ul>'+
             			'</li>'+
             		'</div>'+
			    '</div>'+
			    '<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">'+
			      	'<ul class="nav navbar-nav">'+
	                    '<li><a href="#">ABOUT</a></li>'+
	                    '<li><a href="#">SHIPPING</a></li>'+
	                    '<li class="brand-holder"><a  href="#"><img class="bioevolve-brand" src="img/bioevolve_logo.png" alt="BioZkin Brand"></a></li>'+
	                    '<li><a href="#">PRODUCTS</a></li>'+
	                    '<li><a href="#">CONTACT</a></li>'+
                	'</ul>'+
			    '</div>'+
			'</div>'+
		'</nav>';




	var footer = document.getElementById("footer");
	footer.innerHTML = ''+
		'<div class="container">'+
			'<div class="row">'+
				'<div class="col-md-8">'+
					'<nav class="navbar navbar-default numbing">'+
			  			'<div class="nav-container">'+
			  				'<h1>Inquiries</h1>'+
							'<ul class="nav">'+
								'<li><a href="#">Contact Us</a></li>'+
								'<li><a href="#">Shipping</a></li>'+
								'<li><a href="#">Terms and Conditions</a></li>'+
								'<li><a href="#">Wholesale</a></li>'+
							'</ul>'+
						'</div>'+
						'<div class="nav-container">'+
			  				'<h1>About</h1>'+
							'<ul class="nav">'+
								'<li><a href="#">BioZkin</a></li>'+
								'<li><a href="#">Testimonial</a></li>'+
							'</ul>'+
						'</div>'+
					'</nav>'+
					'<div class="social-icon-group">'+
						'<a href="#"><img src="img/media-icon_fb.png" alt="facebook icon"></a>'+
						'<a href="#"><img src="img/media-icon_instagram.png" alt="instagram icon"></a>'+
					'</div>'+
				'</div>'+
				'<div class="col-md-4">'+
					'<button class="custom-button size-xl">Purchase Now</button>'+
					'<img class="bioevolve-brand" src="img/bioevolve_logo.png" alt="BioZkin Brand">'+
				'</div>'+
			'</div>'+
		'</div>'+
		'<div class="copyright">'+
			'Copyright © 2013-2015 BioZkin™. All Rights Reserved.'+
		'</div>';

});