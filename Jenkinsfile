def pullCodeFromGitHub() {
    git url: 'https://github.com/dabaicaifen/twittermock.git'

    sh(script: 'pod update', returnStatus: false)
}

def runUnitTest() {
    def result = sh(script: 'bundle exec fastlane unit_tests --verbose && exit ${PIPESTATUS[0]}', returnStatus: true)

    if (result != 0) {
        error 'Fail Test-iOS'
    }
}

def runUITest() {
    def result = sh(script: 'bundle exec fastlane ui_tests && exit ${PIPESTATUS[0]}', returnStatus: true)

    if (result != 0) {
        error 'Fail Test-iOS'
    }
}


node { 

    stage("Setup") {
        try {
            pullCodeFromGitHub()
        } catch(e) {
            throw e
        }
    }

    stage("Unit Test") {
        try {
            runUnitTest()
        } catch(e) {
            throw e
        }
    }

    stage("UI Test") {
        try {
            runUITest()
        } catch(e) {
            throw e
        }
    }
}
