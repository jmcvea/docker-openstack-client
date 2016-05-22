# Open Whisk client tooling in Docker
Use a docker image for whisk client tooling!

Rather than futzing with all of the python dependencies to get the whisk cli tools working, use this Docker image as way to get started quickly.
This image uses a small footprint by building off of the Alpine image.

## Quick Start

```bash
docker pull jmcvea/whisk-client

# $(PWD) is mounted to allow for actions requiring host filesystem access.  
# See 'Tips' section below
docker run -ti --rm -v $(PWD):/data jmcvea/whisk-client

# setup the whisk config:
$ wsk property set --namespace {namespace_value}
$ wsk property set --auth {auth_value}
```


## Manual Build
Clone this repository, then:

```bash
# Build a local docker image
docker build -t whisk-client .

# Start a container from the image and launch into a shell in the container.
# Uses a .wskprops file to manage the Whisk configuration env vars.
docker run -it --env-file ~/.wskprops whisk-client

# If you prefer not passing whisk configuration via a env vars:
docker run -it -v $(PWD):/data whisk-client
$ wsk property set --namespace {namespace_value}
$ wsk property set --auth {auth_value}
```


## Tips

### Accessing a host directory
The `/data` directory is exposed as a VOLUME that can be mounted.  This is convenient for whisk
commands that might require reading/writing host filesystems.  It is important to remember that
commands such as `whisk image save` should ensure that the location where the image is saved is
in the `/data` folder when using the `--rm` command line option.  Example:

```bash
docker run -it --rm -v $(PWD):/data --env-file ${WSK_PROPS_FILE:-~/.wskprops} jmcvea/whisk-client wsk property get
```


### Run one-off commands
Run individual commands easily by passing them as the command to run and overriding the default `/bin/bash` command.  For one-off commands, it's a good practice to remove the container with the `--rm` argument so that you don't collect a bunch of orphaned containers.  You will also want to ensure that the which environment is configured as part of starting the container -- easiest via a .wskprops file containing the whisk NAMESPACE and AUTH env vars.

```bash
docker run -ti --rm -v $(PWD):/data --env-file ${WSK_PROPS_FILE:-~/.wskprops} jmcvea/whisk-client wsk property get`
```


### Simplify your typing with aliases
```bash
# alias Whisk client calls with a docker image
alias wsk='docker run -ti --rm -v $PWD:/data --env-file ${WSK_PROPS_FILE:-~/.wskprops} jmcvea/whisk-client'
```


## Contributing

1. Fork ( http://github.com/jmcvea/docker-whisk-client/fork )
2. Create a feature branch (`git checkout -b new-feature`)
3. Commit changes (`git commit -am 'Adding a great new feature'`)
4. Push to the branch (`git push origin new-feature`)
5. Create a new Pull Request


## Copyright

Copyright (c) 2016 Jim McVea

Licensed under MIT
