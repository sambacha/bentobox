#!/bin/bash
touch hash-output.txt
git hash-object --no-filters security.txt >> hash-output.txt
git hash-object --no-filters LAST_COMMIT >> hash-output.txt || exit 127
exit 0
