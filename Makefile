
gems: Gemfile Gemfile.lock

clean: $(vendor)
	rm -rf vendor/

install:
	bundle install --path=vendor/bundler

serve: install $(vendor)
	bundle exec rackup
