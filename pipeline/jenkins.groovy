pipeline {
    agent any
    parameters {
        choice(name: 'OS', choices: ['linux', 'darwin', 'windows', 'all'], description: 'Pick OS')
        choice(name: 'ARCH', choices: ['amd64', 'arm64'], description: 'Pick ARCH')
    }
    stages {
        stage('Example') {
            steps {
                echo "Build image for platform ${params.OS}"
                echo "Build image for Arch: ${params.ARCH}"

                // Установка Docker внутри агента
                sh 'curl -fsSL https://get.docker.com/ | sh'

                withEnv(["TARGETOS=${params.OS}", "TARGETARCH=${params.ARCH}"]) {
                    sh "make image"
                    sh "make push"
                }
            }
        }
    }
}
