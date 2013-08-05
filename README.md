# S3 Stream Backup

Stores data from STDIN in S3 object using multipart upload and removes oldest backups to keep maximum desired backup object count.

## Installing

You will need the following system packages installed: `gcc`, `make` and `libxslt-devel`.

Then you can install the gem as usual:

```bash
gem install s3streambackup
```

## Usage

```bash
s3streambackup mybucket some-backup < some-backup.file
```

Note that you should have your S3 key and secret set in environment `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` or you can specify them in command line with `--key` and `--secret`.

You can store your backup object within prefix by using `--prefix` option e.g.: `--prefix backups/server1/`.

By default two backup copies will be kept. You can change this number by using `--keep` options.

For other usage information use `--help`.

### PostgreSQL backup example

```bash
/bin/su - postgres -c '/usr/bin/pg_dumpall' | xz -2 | s3streambackup --keep 7 --prefix backups/zabbix/ mybucket postgress-all
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

