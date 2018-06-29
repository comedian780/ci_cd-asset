node {
   stage('Preparation') { // for display purposes
      // Get some code from a GitHub repository
      git 'https://github.com/comedian780/ci_cd-asset.git'

   }
     stage('Build') { // for display purposes

      if (isUnix()) {
          /* build docker images */
          sh './buildImages.sh "asset.allgaeu-parcel-service.com" $BUILD_NUMBER parcel-asset-server'

      } else {
          /* build docker image */

          bat 'docker rmi -f asset.allgaeu-parcel-service.com:443/parcel-asset'
          bat 'docker build -t asset.allgaeu-parcel-service.com:443/parcel-asset .'
          bat 'docker image prune -f'
      }

   }
   stage('Deploy to registry'){
    if (isUnix()) {
      sh './registerImages.sh "asset.allgaeu-parcel-service.com" parcel-asset-server'
    } else {
      bat 'docker push "asset.allgaeu-parcel-service.com:443/parcel-asset"'
    }
   }
  }
