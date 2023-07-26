#!/bin/bash
cat $1 | while read fn
do
  echo "Processing file ${fn}"
  prefetch ${fn}
  fasterq-dump ${fn} --split-files
  y=${fn%%_1*}
  echo "Remove folder ${y}"
  rm -rf ${y}
  for qn in *.fast*
  do
    echo "pigz file ${qn}"
    pigz --best --force ${qn}
  done
done

