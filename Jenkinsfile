node {
   stage('Preparation') { // for display purposes
      // Get some code from a GitHub repository
      git 'https://github.com/comedian780/ci_cd-asset.git'

   }
     stage('Build') { // for display purposes

      if (isUnix()) {
          /* build docker images */
          sh 'buildImages.sh "193.174.205.28" $BUILD_NUMBER'

      } else {
          /* build docker image */

          bat 'docker rmi -f 193.174.205.28:443/parcel-asset'
          bat 'docker build -t 193.174.205.28:443/parcel-asset .'
          bat 'docker image prune -f'
      }

   }
   stage('Deploy to registry'){
    if (isUnix()) {
      sh 'docker push "193.174.205.28:443/parcel-asset"'
      sh 'docker push "193.174.205.28:443/parcel-asset-address"'
      sh 'docker push "193.174.205.28:443/parcel-asset-option"'
      sh 'docker push "193.174.205.28:443/parcel-asset-price"'
    } else {
      bat 'docker push "193.174.205.28:443/parcel-asset"'
    }
   }
  }
