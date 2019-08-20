# Site Scanning Dashboard

This repo contains a [jekyll](https://jekyllrb.com/) site which will display
the output of scans that the
[site-scanning](https://github.com/18F/site-scanning) project collected.

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

Once it gets done building, you can look at 
[http://localhost:4000](http://localhost:4000) and see the site.

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
the latest scans.  You can do this with some sort of CI/CD system, for example.

## How to deploy it to Federalist

[Federalist](https://federalist.18f.gov) is a system that deploys static websites
for government.

* [Fork this repo](https://help.github.com/en/articles/fork-a-repo) and, if
  desired, edit the list of domains to display in your fork.
* Get authorized to use federalist.  [Contact](https://federalist.18f.gov/contact/)
  the Federalist using email or their google form on their [Contact page](https://federalist.18f.gov/contact/).
* Go to the [Sites](https://federalistapp.18f.gov/sites) page in the federalist app
  and click on `+Add site`, and add your forked github repo.
* Click on the site, and click on `Site settings` in the navbar on the left.  Click on
  `Advanced settings`, and add `schedule: nightly` to the Live site Site configuration
  text field.
  This will ensure that the site will be redeployed every day, so that it pulls down the
  latest and greatest scan data.
* You can consult the [Federalist Launch Checklist](https://federalist.18f.gov/documentation/launch-checklist/)
  for information on how to set up a custom domain name, or you can just go to
  the [sites](https://federalistapp.18f.gov/sites) page and click on `View site`
  to get to your site.

Viola!  The site should deploy and keep itself up to date.

## How to edit the list of domains to display

The `_config.yml` file has a list of domains called `domainlist`.  Change
that list to suit your needs.

Once you have updated these, you will need to do a build/deploy to see the
changes.

## How to edit where the site-scanner site lives

Right now this is hardcoded to a temporary location.  You can configure
this by editing the `_config.yml` file and setting the `scanner_url`
to be the new location.  Make sure there is a `/` at the end of the URL.

Once you have updated these, you will need to do a build/deploy to see the
changes.


Have fun!
