# S3 Stream Backup

Stores data from STDIN in S3 object using multipart upload and removes oldest backups to keep maximum desired backup object count.
Restore tool included.

## Installing

You will need the following system packages installed: `gcc`, `make` and `libxslt-devel`.

Then you can install the gem as usual:

```bash
gem install s3streambackup
```

## Usage

```bash
# store some-backup.file in mybucket bucket and name it my-backup
s3streambackup mybucket my-backup < some-backup.file

# list available backups of my-backup
s3streamrestore mybucket my-backup

# restore my-backup backup from 2013-08-06 09:03:17 UTC
s3streamrestore mybucket my-backup 130806_090317 > some-backup.file
```

Note that you should have your S3 key and secret set in environment variables `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` or you can specify them in command line with `--key` and `--secret` options.

You can store your backup object within prefix by using `--prefix` option e.g.: `--prefix backups/server1/`.
Additionally you can postfix your backup objects by using `--postfix` option e.g: `--postfix .sql.gz`.

By default two backup copies will be kept. You can change this number by using `--keep` options.

For other usage information use `--help`.

### PostgreSQL backup example

```bash
# backup to S3
su - postgres -c 'pg_dumpall' | xz -2 | s3streambackup --keep 7 --prefix backups/zabbix/ mybucket postgress-all

# restore could look like this
s3streambackup --prefix backups/zabbix/ mybucket postgress-all 130806_090317 | xz -d | su - postgres -c 'psql'
```

## Contributing to S3 Stream Backup
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2013 Jakub Pastuszek. See LICENSE.txt for
further details.

