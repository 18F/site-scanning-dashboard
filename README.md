# Site Scanning Dashboard

This repo contains a jekyll site which will display the output of scans that
the [site-scanning](https://github.com/18F/site-scanning) project collected.

It can be built and viewed locally, pushed up to federalist, or deployed on cloud.gov.

This site currently is hardcoded to display the scan results for TTS domains, but
you can customize the domain list.  It also will only pull down scan results whenever
you build or serve the site, so if you are deploying this through CI/CD, you will want
to build/deploy this once a day to ensure that it has the latest scan results.

## How to view it locally

* Make sure you have a full ruby development environment installed.  We suggest
	[rbenv](https://github.com/rbenv/rbenv#installation), but there are plenty of
	other ways to do this too.
* Make sure you have the jekyll gem installed: `gem install jekyll bundler`
* cd into the `site-scanning-dashboard` repo.
* `bundle exec jekyll serve`

You now can look at [http://localhost:4000](http://localhost:4000) and see the
site.

## How to deploy it to cloud.gov or some other Cloud Foundry instance

* Make sure you have a full ruby development environment installed.  We suggest
	[rbenv](https://github.com/rbenv/rbenv#installation), but there are plenty of
	other ways to do this too.
* Make sure you have the jekyll gem installed: `gem install jekyll bundler`
* cd into the `site-scanning-dashboard` repo.
* `bundle exec jekyll build`
* Make sure you are logged into cloud.gov and are targeting an org/space.  `cf t` should not return an error.
* `cf push`

The app will deploy, and cloud.gov will tell you the route that you will need
to go to in your browser to view the data.

You will want to do a build/deploy like this once a day to ensure that it pulls down
the latest scans.

## How to edit the list of domains to display

The `_config.yml` file has a list of domains called `domainlist`, and a list of
where to get the scan data under `jekyll_get`.  Add an entry to both lists for
each domain you want to be in there.

Once you have updated these, you will need to do a build/deploy to see the
changes.


Have fun!
