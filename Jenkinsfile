node {
   stage('Preparation') { // for display purposes
      // Get some code from a GitHub repository
      git 'https://github.com/comedian780/ci_cd-asset.git'

   }
     stage('Build') { // for display purposes

      if (isUnix()) {
          /* build docker images */
          sh './buildImages.sh "asset.allgaeu-parcel-service.com" $BUILD_NUMBER'

      } else {
          /* build docker image */

          bat 'docker rmi -f asset.allgaeu-parcel-service.com:443/parcel-asset'
          bat 'docker build -t asset.allgaeu-parcel-service.com:443/parcel-asset .'
          bat 'docker image prune -f'
      }

   }
   stage('Deploy to registry'){
    if (isUnix()) {
      sh 'docker push "asset.allgaeu-parcel-service.com:443/parcel-asset"'
      sh 'docker push "asset.allgaeu-parcel-service.com:443/parcel-asset-address"'
      sh 'docker push "asset.allgaeu-parcel-service.com:443/parcel-asset-option"'
      sh 'docker push "asset.allgaeu-parcel-service.com:443/parcel-asset-price"'
    } else {
      bat 'docker push "asset.allgaeu-parcel-service.com:443/parcel-asset"'
    }
   }
  }
