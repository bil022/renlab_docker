#!/usr/bin/perl

while (<DATA>) {
  if (/^PUBLICATION/) {
    open PUB, "<publication.html" or die "publication?";
    while (<PUB>) {
      print;
    }
    next;
  }
  print;
}

__END__
<!doctype html>
<html class="no-js" lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Publications</title>

    <link rel="stylesheet" type="text/css" href="https://renlab.sdsc.edu/renlab_website//assets/css/styles_feeling_responsive.css">

  

	<script src="https://renlab.sdsc.edu/renlab_website//assets/js/modernizr.min.js"></script>

	<script src="https://ajax.googleapis.com/ajax/libs/webfont/1.5.18/webfont.js"></script>
	<script>
		WebFont.load({
			google: {
				families: [ 'Lato:400,700,400italic:latin', 'Volkhov::latin' ]
			}
		});
	</script>

	<noscript>
		<link href='https://fonts.googleapis.com/css?family=Lato:400,700,400italic%7CVolkhov' rel='stylesheet' type='text/css'>
	</noscript>


	<!-- Search Engine Optimization -->
	<meta name="description" content="»Feeling Responsive« is a responsive theme for Jekyll based on the fabulous foundation framework with beautiful typography and a bright color palette.">
	<meta name="google-site-verification" content="Vk0IOJ2jwG_qEoG7fuEXYqv0m2rLa8P778Fi_GrsgEQ">
	<meta name="msvalidate.01" content="0FB4C028ABCF07C908C54386ABD2D97F" >
	
	<link rel="author" href="https://plus.google.com/u/0/118311555303973066167">
	
	
	<link rel="canonical" href="https://renlab.sdsc.edu/renlab_website//publication/">


	<!-- Facebook Open Graph -->
	<meta property="og:title" content="Publications">
	<meta property="og:description" content="»Feeling Responsive« is a responsive theme for Jekyll based on the fabulous foundation framework with beautiful typography and a bright color palette.">
	<meta property="og:url" content="https://renlab.sdsc.edu/renlab_website//publication/">
	<meta property="og:locale" content="en_EN">
	<meta property="og:type" content="website">
	<meta property="og:site_name" content="RENLAB">
	
	<meta property="article:author" content="https://www.facebook.com/phlow.media">


	
	<!-- Twitter -->
	<meta name="twitter:card" content="summary">
	<meta name="twitter:site" content="phlow">
	<meta name="twitter:creator" content="phlow">
	<meta name="twitter:title" content="Publications">
	<meta name="twitter:description" content="»Feeling Responsive« is a responsive theme for Jekyll based on the fabulous foundation framework with beautiful typography and a bright color palette.">
	
	

	<link type="text/plain" rel="author" href="https://renlab.sdsc.edu/renlab_website//humans.txt">

	

	

	<link rel="icon" sizes="32x32" href="https://renlab.sdsc.edu//renlab_website/assets/img/favicon-32x32.png">

	<link rel="icon" sizes="192x192" href="https://renlab.sdsc.edu//renlab_website/assets/img/touch-icon-192x192.png">

	<link rel="apple-touch-icon-precomposed" sizes="180x180" href="https://renlab.sdsc.edu//renlab_website/assets/img/apple-touch-icon-180x180-precomposed.png">

	<link rel="apple-touch-icon-precomposed" sizes="152x152" href="https://renlab.sdsc.edu//renlab_website/assets/img/apple-touch-icon-152x152-precomposed.png">

	<link rel="apple-touch-icon-precomposed" sizes="144x144" href="https://renlab.sdsc.edu//renlab_website/assets/img/apple-touch-icon-144x144-precomposed.png">

	<link rel="apple-touch-icon-precomposed" sizes="120x120" href="https://renlab.sdsc.edu//renlab_website/assets/img/apple-touch-icon-120x120-precomposed.png">

	<link rel="apple-touch-icon-precomposed" sizes="114x114" href="https://renlab.sdsc.edu//renlab_website/assets/img/apple-touch-icon-114x114-precomposed.png">

	
	<link rel="apple-touch-icon-precomposed" sizes="76x76" href="https://renlab.sdsc.edu//renlab_website/assets/img/apple-touch-icon-76x76-precomposed.png">

	<link rel="apple-touch-icon-precomposed" sizes="72x72" href="https://renlab.sdsc.edu//renlab_website/assets/img/apple-touch-icon-72x72-precomposed.png">

	<link rel="apple-touch-icon-precomposed" href="https://renlab.sdsc.edu//renlab_website/assets/img/apple-touch-icon-precomposed.png">	

	<meta name="msapplication-TileImage" content="https://renlab.sdsc.edu//renlab_website/assets/img/msapplication_tileimage.png">

	<meta name="msapplication-TileColor" content="#fabb00">


	

</head>
<body id="top-of-page" class="page-fullwidth">
	
	<div id="navigation" class="sticky">
  <nav class="top-bar" role="navigation" data-topbar>
    <ul class="title-area">
      <li class="name">
      <h1 class="show-for-small-only"><a href="https://renlab.sdsc.edu/renlab_website/" class="icon-tree"> RENLAB</a></h1>
    </li>
       <!-- Remove the class "menu-icon" to get rid of menu icon. Take out "Menu" to just have icon alone -->
      <li class="toggle-topbar menu-icon"><a href="#"><span>Nav</span></a></li>
    </ul>
    <section class="top-bar-section">

      <ul class="right">
        

              

          
          
        

              

          
          
        

              

          
          
        

              

          
          
        

              

          
          
        

              

          
          
        

              

          
          
            
            
              <li class="divider"></li>
              <li><a  href="https://renlab.sdsc.edu/renlab_website//search/">Search</a></li>

            
            
          
        

              

          
          
            
            
              <li class="divider"></li>
              <li><a  href="https://renlab.sdsc.edu/renlab_website//contact/">Contact</a></li>

            
            
          
        
        
      </ul>

      <ul class="left">
        

              

          
          

            
            
              <li><a  href="https://renlab.sdsc.edu/renlab_website//">Home</a></li>
              <li class="divider"></li>

            
            
          
        

              

          
          

            
            
              <li><a  href="https://renlab.sdsc.edu/renlab_website//news/">News</a></li>
              <li class="divider"></li>

            
            
          
        

              

          
          

            
            
              <li><a  href="https://renlab.sdsc.edu/renlab_website//research/">Research</a></li>
              <li class="divider"></li>

            
            
          
        

              

          
          

            
            
              <li><a  href="https://renlab.sdsc.edu/renlab_website//team/">Team</a></li>
              <li class="divider"></li>

            
            
          
        

              

          
          

            
            

              <li class="has-dropdown active">
                <a  href="https://renlab.sdsc.edu/renlab_website//publication/">Publication</a>

                  <ul class="dropdown">
                    

                      

                      <li><a  href="https://renlab.sdsc.edu/renlab_website//publication/preprint/">Preprint</a></li>
                    
                  </ul>

              </li>
              <li class="divider"></li>
            
          
        

              

          
          

            
            
              <li><a  href="https://renlab.sdsc.edu/renlab_website//download/">Download</a></li>
              <li class="divider"></li>

            
            
          
        

              

          
          
        

              

          
          
        
        
      </ul>
    </section>
  </nav>
</div><!-- /#navigation -->

	

	

<div id="masthead-no-image-header">
	<div class="row">
		<div class="small-12 columns">
			<a id="logo" href="https://renlab.sdsc.edu//renlab_website/" title="RENLAB – Laboratory of Gene Regulation">
				<img src="https://renlab.sdsc.edu/renlab_website//assets/img/logo.png" alt="RENLAB – Laboratory of Gene Regulation">
			</a>
		</div><!-- /.small-12.columns -->
	</div><!-- /.row -->
</div><!-- /#masthead -->









	


<div class="row t30">
	<div class="medium-12 columns">
		<article>
			<header>
				
				<h1>Publications</h1>
			</header>

			

			<a href="https://scholar.google.com/citations?hl=en&user=XU7ZT5kAAAAJ"> For a complete list of Bing Ren's publications, click here.</a> <br>
<a href="/renlab_website/publication/preprint/">For preprints, please click here.  </a><br>
Below is a list of representative peer-reviewed publications. (*equal contribution. <sup>#</sup>co-correspondence.)

PUBLICATION

		</article>
	</div><!-- /.medium-12.columns -->
</div><!-- /.row -->




	
	     <div id="up-to-top" class="row">
      <div class="small-12 columns" style="text-align: right;">
        <a class="iconfont" href="#top-of-page">&#xf108;</a>
      </div><!-- /.small-12.columns -->
    </div><!-- /.row -->


    <footer id="footer-content" class="bg-grau">

      <div id="subfooter">
        <nav class="row">
          <section id="subfooter-left" class="small-12 medium-6 columns credits">
            <p>Created with &hearts; by <a href="https://shawnzhangyx.github.io/">Yanxiao Zhang</a> with <a href="https://jekyllrb.com/" target="_blank">Jekyll</a> based on <a href="https://phlow.github.io/feeling-responsive/">Feeling Responsive</a>.</p>
          </section>

          <section id="subfooter-right" class="small-12 medium-6 columns">
            <ul class="inline-list social-icons">
            
              <li><a href="https://github.com/ren-lab" target="_blank" class="icon-github" title="Code und mehr..."></a></li>
            
            </ul>
          </section>
        </nav>
      </div><!-- /#subfooter -->
    </footer>

	

	


<script src="https://renlab.sdsc.edu/renlab_website//assets/js/javascript.min.js"></script>







<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-96143943-2', 'auto');
  ga('set', 'anonymizeIp', true);
  ga('send', 'pageview');

</script>








</body>
</html>

