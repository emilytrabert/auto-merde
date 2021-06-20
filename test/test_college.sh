#!/bin/sh

psql -f college/college.sql
pg_dump -s > college/college_dump.sql
ruby ../parse.rb college/college_dump.sql college/college_output.md
