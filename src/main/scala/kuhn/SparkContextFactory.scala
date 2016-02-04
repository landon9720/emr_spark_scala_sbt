package kuhn

import org.apache.spark.SparkContext

object SparkContextFactory {

  implicit val sparkContext = new SparkContext

  private val hadoopConf = sparkContext.hadoopConfiguration
  hadoopConf.set("fs.s3a.impl", "org.apache.hadoop.fs.s3a.S3AFileSystem")
  hadoopConf.set("fs.s3a.fast.upload", "true")
  hadoopConf.set("fs.s3a.access.key", sys.env.getOrElse("AWS_ACCESS_KEY_ID", sys.error("missing AWS_ACCESS_KEY_ID")))
  hadoopConf.set("fs.s3a.secret.key", sys.env.getOrElse("AWS_SECRET_ACCESS_KEY", sys.error("missing AWS_SECRET_ACCESS_KEY")))
  // see http://deploymentzone.com/2015/12/20/s3a-on-spark-on-aws-ec2/
  // see https://hadoop.apache.org/docs/stable/hadoop-aws/tools/hadoop-aws/index.html

  println("Spark context ready with configuration:\n" + sparkContext.getConf.toDebugString)
}