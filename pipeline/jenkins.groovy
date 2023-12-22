pipeline {
    agent any
    parameters {
        choice(name: 'OS', choices: ['linux', 'darwin', 'windows', 'all'], description: 'Pick OS')
        choice(name: 'ARCH', choices: ['amd64', 'arm64'], description: 'Pick ARCH')
    }
    stages {
        stage('Run Docker-in-Docker') {
            agent {
                docker {
                    image 'docker:19.03.12'
                    args '-v /var/run/docker.sock:/var/run/docker.sock'
                }
            }
            steps {
                script {
                    echo "Build image for platform ${params.OS}"
                    echo "Build image for Arch: ${params.ARCH}"

                    // Продолжение вашего кода сборки образа и пуша
                    withEnv(["TARGETOS=${params.OS}", "TARGETARCH=${params.ARCH}"]) {
                        sh "make image"
                        sh "make push"
                    }
                }
            }
        }
    }
}