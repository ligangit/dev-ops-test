def createVersion() {
    // 定义一个版本号作为当次构建的版本，输出结果 20191210175842
    return new Date().format('yyyyMMddHHmmss')
}


pipeline {
  agent none
    environment {
        //定义备份的包
        BUILD_ID = createVersion()
    }
    stages {
        stage('Clone Code') {
            agent any
            steps {
                echo "1.Git Clone Code"
                git url: "https://github.com/ligangit/dev-ops-test.git"
            }
        }
        stage('Maven Build') {
            agent {
                docker {
                    image 'maven:latest'
                    args '-v /var/jenkins_home/repository:/root/.m2'
                }
            }
            steps {
                echo "2.Maven Build Stage"
                sh 'mvn -B clean package -Dmaven.test.skip=true'
            }
        }
        stage('Image Build') {
            agent any
            steps {
            echo "3.Image Build Stage"
            sh 'docker build -f Dockerfile --build-arg jar_name=target/dev-ops-test-0.0.1-SNAPSHOT.jar -t dev-ops-test:${BUILD_ID} . '
            sh 'docker tag  dev-ops-test:${BUILD_ID}  registry.cn-shanghai.aliyuncs.com/dev-ops-demo/dev-ops-v1:${BUILD_ID}'
            }
        }
        stage('Push') {
            agent any
            steps {
            echo "4.Push Docker Image Stage"
            sh "docker login --username=ligang@1117199394288256 registry.cn-shanghai.aliyuncs.com -p Hjh123456789"
            sh "docker push registry.cn-shanghai.aliyuncs.com/dev-ops-demo/dev-ops-v1:${BUILD_ID}"
            }
        }
    }
}