# About

This repository contains packages used for reading
and writing simple formats like CSV, etc. for
Cuis Smalltalk.

# Usage TableStreamrs.pck.st

TableStreamers are readers for table based formats. These
formats are TSV, CSV.

Reading a complete csv file (aka "slurping" in lisp):

```smalltalk
path := '/home/user/something_fancy.csv'.
csvReader := CsvReader on: (path asFileEntry readStream).
csvReader recordBuilder: TableDictionaryRecordBuilder new.
csvReader upToEnd.
```

Reads the whole file and produces dictionary records
based on the first line, which is to be expected be representing
headers.

When a file without any headers is read, then the default
array based record construction should be used.

```smalltalk
path := '/home/user/something_fancy.csv'.
csvReader := CsvReader on: (path asFileEntry readStream).
csvReader upToEnd.
```

# License

MIT License

# Author

Josef Philip Bernhart (jpb)
