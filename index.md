---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: home
---

Scan Results:
<table>
	<tr>
		<th>Domain</th>
		{% for domain in site.domainlist.first %}
			{% for scan in site.data[domain] %}
				{% if scan.scantype == 'uswds2' %}
					<th>USWDS Score</th><th>USWDS Version</th>
				{% else %}
					{% for item in scan.data %}
						<th>{{item[0]}}</th>
					{% endfor %}
				{% endif %}
			{% endfor %}
			<th>API</th>
		{% endfor %}
	</tr>
{% for domain in site.domainlist %}
	<tr>
		<td><strong>{{domain}}</strong></td>
		{% for scan in site.data[domain] %}
			{% if scan.scantype == 'uswds2' %}
				<td>{{scan.data.total_score}}</td><td>{{scan.data.uswdsversion}}</td>
			{% else %}
				{% for item in scan.data %}
					<td>{{item[1]}}</td>
				{% endfor %}
			{% endif %}
		{% endfor %}
		<td><a href="{{site.scanner_url}}api/v1/domains/{{domain}}/">link</a></td>
	</tr>
{% endfor %}
</table>

<a href="{{site.scanner_url}}">Click here</a> to go to the main searchable site.
