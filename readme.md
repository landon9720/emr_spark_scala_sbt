## about

A empty project for:
    
* AWS EMR
* Apache Spark
* Scala
* Sbt with assembly

## build

    brew install sbt
    sbt clean ~assembly

## run locally

    brew install apache-spark
    ./submit
    
## run on AWS EMR

    ./deploy
    ./submit_emr
