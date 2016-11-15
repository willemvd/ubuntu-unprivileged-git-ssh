#!/bin/bash

echo -e ",s/1234321/`id -u`/g\\012 w" | ed -s /etc/passwd