---
layout: page
title: data.json
permalink: /datagov/
---

Scan Results:
<table>
	<tr>
		<th>Domain</th>
		<th>Agency</th>
		<th>Final URL</th>
		<th>API Link</th>
	</tr>
{% for d in site.data['datajsondata'] %}
	<tr>
		<td><strong>{{ d['domain'] }}</strong></td>
		<td>{{ d['agency'] }}</td>
		<td>{{ d['final_url'] }}</td>
		<td><a href="{{site.scanner_url}}api/v1/domains/{{ d['domain'] }}/">link</a></td>
	</tr>
{% endfor %}
</table>

<a href="{{site.scanner_url}}">Click here</a> to go to the main searchable site.
