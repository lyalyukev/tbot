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
                sh "cat /etc/os-release"
                cat /proc/cpuinfo
                sh "make build"

                echo "Build image for Arch: ${params.ARCH}"

            }
        }
    }
}