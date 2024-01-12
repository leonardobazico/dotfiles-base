#!/bin/sh

KEY_PATH="$HOME/.ssh/id_rsa"; \
PRINT_PUBLIC_KEY="cat $KEY_PATH.pub "; \
GENERATE_KEY="ssh-keygen -t rsa -N '' -f $KEY_PATH"; \
COPY_KEY="$PRINT_PUBLIC_KEY | pbcopy"; \
  { sh -c $PRINT_PUBLIC_KEY || \
    { echo "Generating ssh key" && sh -c $GENERATE_KEY; }; } && \
  sh -c $COPY_KEY && echo "Copied ssh key to clipboard"
