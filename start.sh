#!/bin/bash

mkdir -p /config/couchpotato

exec python /opt/couchpotato/CouchPotato.py --config_file=/config/couchpotato/config.ini --data_dir=/config/couchpotato/data