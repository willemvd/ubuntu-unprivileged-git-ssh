#!/bin/bash

echo -e ",s/git:x:99:/git:x:`id -u`:/g\\012 w" | ed -s /etc/passwd