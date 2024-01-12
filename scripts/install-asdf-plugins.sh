#!/bin/bash

asdf plugin add golang || echo $0
asdf plugin add java https://github.com/halcyon/asdf-java.git || echo $0
asdf plugin add nodejs || echo $0
asdf nodejs update-nodebuild
asdf nodejs resolve lts --latest-available
asdf plugin add python || echo $0
