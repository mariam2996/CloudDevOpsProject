def call(Map config = [:]) {
    pipeline {
        agent any

        environment {
            REGISTRY = 'floci-aws-ecr-registry:5000'
            IMAGE_NAME = "${config.imageName}"
            SERVICE_DIR = "${config.serviceDir}"
            MANIFEST_PATH = "${config.manifestPath}"
            IMAGE_TAG = "${BUILD_NUMBER}"
        }

        stages {
            stage('Build') {
                steps {
                    sh '''
                        docker build \
                          -t ${REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG} \
                          ${SERVICE_DIR}
                    '''
                }
            }

            stage('Scan') {
                steps {
                    sh '''
                        trivy image \
                          --exit-code 0 \
                          --severity HIGH,CRITICAL \
                          ${REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}
                    '''
                }
            }

            stage('Push') {
                steps {
                    sh '''
                        docker push \
                          ${REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}
                    '''
                }
            }

            stage('Delete Local') {
                steps {
                    sh '''
                        docker rmi \
                          ${REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG} || true
                    '''
                }
            }

            stage('Update Manifests') {
                steps {
                    sh '''
                        sed -i \
                          "s#image: .*${IMAGE_NAME}.*#image: ${REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}#" \
                          ${MANIFEST_PATH}
                    '''
                }
            }

            stage('Push Manifests') {
                steps {
                    sh '''
                        git config user.name "jenkins"
                        git config user.email "jenkins@local"

                        git add ${MANIFEST_PATH}

                        git diff --cached --quiet || \
                          git commit -m "Update ${IMAGE_NAME} image to build ${IMAGE_TAG}"

                        git push origin HEAD:main
                    '''
                }
            }
        }
    }
}
