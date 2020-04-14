#!/bin/sh
TAG=`date +"%Y%m%d"`
docker build -t ustay/php-apache:${TAG} .
