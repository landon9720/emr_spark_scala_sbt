#!/bin/bash
set -ue
S3_BUCKET=your_s3_bucket
aws s3 cp target/scala-2.10/emr_spark_scala_sbt-assembly-1.0.jar s3://$S3_BUCKET/emr_spark_scala_sbt-assembly-1.0.jar
