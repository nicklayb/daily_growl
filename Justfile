docker_registry := "nboisvert"
docker_tag := "latest"
docker_image := "daily_growl" + ":" + docker_tag
docker_remote_image := docker_registry / docker_image

# Starts the dev environment by default
default: dev

echo:
	echo {{docker_remote_image}}

docker-build:
	docker build -f ./dockerfiles/Dockerfile -t {{docker_image}} .

docker-tag:
	docker tag {{docker_image}} {{docker_remote_image}}

docker-push:
	docker push {{docker_remote_image}}

release-docker: docker-build docker-tag docker-push

docker-run: 
	docker run \
		-e SECRET_KEY_BASE=$SECRET_KEY_BASE \
		-e LIVE_VIEW_SALT=$LIVE_VIEW_SALT \
		-p 4001:4000 \
		{{docker_image}}

# Fetches deps, setup assets and create the database
setup: deps setup-assets create-db reset-db

# Starts a development server
dev: deps create-db iex-server

# Install Node assets
setup-assets:
	npm install --prefix assets

# Creates database
create-db:
	mix ecto.create

# Resets database
reset-db:
	mix ecto.reset

# Starts an iex session
iex:
	iex -S mix

# Starts an iex session with Phoenix server
iex-server:
	iex -S mix phx.server

# Clean up dependencies
clean:
	rm -rf _build deps

# Clean dependencies and reinstall them
refresh: clean deps

# Install dependencies
deps:
	mix deps.get

