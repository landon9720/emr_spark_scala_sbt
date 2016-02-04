#!/bin/bash

/usr/local/Cellar/apache-spark/1.6.0/bin/spark-submit \
  --class kuhn.Example \
  --master local[1] \
  --name emr_spark_scala_sbt \
  --packages org.apache.hadoop:hadoop-aws:2.7.1 \
  target/scala-2.10/emr_spark_scala_sbt-assembly-1.0.jar
