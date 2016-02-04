sbtVersion := "0.13.9"

scalaVersion := "2.10.5"

name := "emr_spark_scala_sbt"

version := "1.0"

libraryDependencies ++= Seq(
  "org.apache.spark" % "spark-core_2.10" % "1.6.0" % "provided",
  "org.apache.spark" % "spark-sql_2.10" % "1.6.0" % "provided"
)
