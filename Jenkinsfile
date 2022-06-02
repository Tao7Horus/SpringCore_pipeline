image: docker/compose:alpine-1.27.4

services:
  - docker:dind

stages:
  - build
  - test
  - release

before_script:
  - docker version
  - docker login -u tinhchieuphuoc -p tao7horus registry.gitlab.com/tinhchieuphuoc/cicd-automation-test
build:
  stage: build
  script:
    - docker pull registry.gitlab.com/tinhchieuphuoc/cicd-automation-test:latest
    - docker build --cache-from registry.gitlab.com/tinhchieuphuoc/cicd-automation-test:latest --tag registry.gitlab.com/tinhchieuphuoc/cicd-automation-test:$CI_COMMIT_SHA .
    - docker push registry.gitlab.com/tinhchieuphuoc/cicd-automation-test:$CI_COMMIT_SHA
test:
  stage: test
  before_script:
    - docker-compose version
    - docker login -u tinhchieuphuoc -p tao7horus registry.gitlab.com/tinhchieuphuoc/cicd-automation-test
    - docker pull registry.gitlab.com/tinhchieuphuoc/cicd-automation-test:$CI_COMMIT_SHA
    - docker tag registry.gitlab.com/tinhchieuphuoc/cicd-automation-test:$CI_COMMIT_SHA registry.gitlab.com/tinhchieuphuoc/cicd-automation-test:latest
  script:
    - docker-compose up -d
    - sleep 15
    - docker-compose exec -T app npm run test
  coverage: /All files[^|]*\|[^|]*\s+([\d\.]+)/ # Thêm vào dòng này
  artifacts: # Thêm vào ph?n này
    paths:
    - coverage/

release-tag:
  variables:
    GIT_STRATEGY: none
  stage: release
  except:
    - master
  script:
    - docker pull registry.gitlab.com/tinhchieuphuoc/cicd-automation-test:$CI_COMMIT_SHA
    - docker tag registry.gitlab.com/tinhchieuphuoc/cicd-automation-test:$CI_COMMIT_SHA registry.gitlab.com/tinhchieuphuoc/cicd-automation-test:$CI_COMMIT_REF_NAME
    - docker push registry.gitlab.com/tinhchieuphuoc/cicd-automation-test:$CI_COMMIT_REF_NAME

release-latest:
  variables:
    GIT_STRATEGY: none
  stage: release
  only:
    - master
  script:
    - docker pull registry.gitlab.com/tinhchieuphuoc/cicd-automation-test:$CI_COMMIT_SHA
    - docker tag registry.gitlab.com/tinhchieuphuoc/cicd-automation-test:$CI_COMMIT_SHA registry.gitlab.com/tinhchieuphuoc/cicd-automation-test:latest
    - docker push registry.gitlab.com/tinhchieuphuoc/cicd-automation-test:latest
