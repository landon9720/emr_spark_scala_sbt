#!/bin/bash
set -ue

S3_BUCKET=your_s3_bucket

cat << EOM > bootstrap
  #!/bin/bash
  aws s3 cp s3://$S3_BUCKET/emr_spark_scala_sbt-assembly-1.0.jar /home/hadoop/emr_spark_scala_sbt-assembly-1.0.jar
EOM
aws s3 cp bootstrap s3://$S3_BUCKET/bootstrap

cat << EOM > instance-groups.json
[
  {
    "InstanceGroupType": "MASTER",
    "InstanceCount": 1,
    "InstanceType": "m3.xlarge",
    "Name": "Spark Master"
  },
  {
    "InstanceGroupType": "CORE",
    "InstanceCount": 3,
    "InstanceType": "m3.xlarge",
    "Name": "Spark Executors"
  }
]
EOM

cat << EOM > bootstrap-action.json
[
  {
    "Name": "copy emr_spark_scala_sbt-assembly-1.0.jar",
    "Path": "s3://$S3_BUCKET/bootstrap",
    "Args": []
  }
]
EOM

cat << EOM > configurations.json
[
  {
    "Classification": "spark",
    "Properties": {
      "maximizeResourceAllocation": "true"
    },
    "Configurations": []
  },
  {
    "Classification": "spark-env",
    "Properties": {
    },
    "Configurations": [
      {
        "Classification": "export",
        "Properties": {
          "", ""
        },
        "Configurations": [
        ]
      }
    ]
  }
]
EOM

cat << EOM > steps.json
[
  {
    "Name": "emr_spark_scala_sbt",
    "Type": "SPARK",
    "Args": [
      "--class", "kuhn.Example",
      "/home/hadoop/emr_spark_scala_sbt-assembly-1.0.jar"
    ],
    "ActionOnFailure": "TERMINATE_CLUSTER"
  }
]
EOM

aws emr create-cluster \
  --release-label emr-4.3.0 \
  --region us-east-1 \
  --instance-groups file://instance-groups.json \
  --auto-terminate \
  --name "emr_spark_scala_sbt" \
  --log-uri "s3://$S3_BUCKET/emr_log" \
  --ec2-attributes '{ "KeyName" : "yourkey" }' \
  --use-default-roles \
  --enable-debugging \
  --applications Name=SPARK \
  --bootstrap-action file://bootstrap-action.json \
  --configurations file://configurations.json \
  --steps file://steps.json

rm bootstrap
rm instance-groups.json
rm bootstrap-action.json
rm configurations.json
rm steps.json
