#!/bin/sh

# Set up the wsk configuration
# Check that the AUTH env var is set
if [ -z ${AUTH+x} ]; then
  echo "The AUTH property should be set in /root/.wskprops"
else
  echo AUTH=$AUTH >> /root/.wskprops
fi

# Check that the NAMESPACE env var is set
if [ -z ${NAMESPACE+x} ]; then
  echo "The NAMESPACE property should be set in /root/.wskprops"
else
  echo NAMESPACE=$NAMESPACE >> /root/.wskprops
fi

# Set up autocomplete for wsk
echo 'eval "$(register-python-argcomplete wsk)"' >> "$HOME/.bashrc"

# if arguments were passed, then send them to the wsk command; otherwise
# drop into a normal bash shell
if [ $# -gt 0 ]; then
  echo "Executing $*"
  wsk $*
else
  /bin/bash
fi
