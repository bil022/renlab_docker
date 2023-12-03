---
layout: page-fullwidth
title: "Team"
meta_title: "Lab members"
subheadline: # "Wufoo-powered contact forms"
#teaser: "Get in touch with me? Use the contact form."
permalink: "/team1/"
---
##### Principle Investigator
<br>
 <img src="{{site.urlimg}}team-bingren.jpg">
<b> <a href="http://www.ludwigcancerresearch.org/location/san-diego-branch/bing-ren-lab"> Bing Ren, PhD. </a> </b>
<hr>
##### Current members
<br>
<div class ="row">
{% for member in site.data.labmembers %}
 <div class = "small-12 medium-6 large-3 columns">
 {% if member.image %}  <img src="{{site.urlimg}}{{member.image}}"> {% endif %}
 <p> <b>{{member.name}}</b>
 {% if member.url %} <a href="{{member.url}}"> &lt;website&gt;</a> {% endif %} <br>
 {{member.position}} <br>
 {{member.email}} </p>
 </div> <!-- small-12 large-4 columns -->
{% endfor %}
</div> <!-- row -->
<hr>
##### Alumni (incomplete)
