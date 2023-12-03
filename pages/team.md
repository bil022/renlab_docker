---
layout: page-fullwidth
title: "Team"
meta_title: "Lab members"
subheadline: # "Wufoo-powered contact forms"
#teaser: "Get in touch with me? Use the contact form."
permalink: "/team/"
---
##### Principle Investigator
<br>
 <img src="{{site.urlimg}}team-bingren.jpg">
<b> <a href="{{site.url}}{{site.baseurl}}bing/"> Bing Ren, PhD. </a> </b>
<hr>
##### Current members
<br>
<table>
{% for member in site.data.labmembers %}
 <tr>
 <td> <b> <a href="mailto:{{member.email}}">{{member.name}} </a>  </b>
 {% if member.url %} <a href="{{member.url}}"> &lt;website&gt;</a> {% endif %} </td>
 <td>{{member.position}} </td>
 </tr>
{% endfor %}
</table>
<hr>
##### Alumni


<table>
 <tr><th> Name </th> <th>Prev. Pos</th>><th> Year</th> <th> Curr. Pos </th> </tr>
{% for member in site.data.alumni %}
 <tr>
 <td> <b>{{member.name}} </b>
 {% if member.url %} <a href="{{member.url}}"> &lt;website&gt;</a> {% endif %} </td>
 <td> {{member.prev_position}} </td>
 <td>{{member.year}} </td>
 <td>{{member.curr_position}} </td>
 </tr>
{% endfor %}
</table>

(Please contact website <a href="mailto:shz254@ucsd.edu">admin</a> to correct any mistakes or missing information.)
