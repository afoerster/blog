init:
	sudo gem install bundler
	bundle install
	bundle exec jekyll _3.3.0_ new posts

serve: 
	bundle exec jekyll serve

open:
	open http://localhost:4000


