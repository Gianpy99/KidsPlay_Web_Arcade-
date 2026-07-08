// =============================================================================
// Jenkinsfile - CI/CD per KidsPlay Web Arcade (http.server statico) sul Pi
// -----------------------------------------------------------------------------
// Build immagine -> deploy container (:8092) -> health check ->
// auto-registrazione nel Family Portal (aggiorna il registro live sul Pi).
// =============================================================================
pipeline {
    agent any

    options { disableConcurrentBuilds() }

    triggers { pollSCM('H/3 * * * *') }

    environment {
        IMAGE       = 'kidsplay:latest'
        CONTAINER   = 'kidsplay'
        HOST_PORT   = '8092'
        // Metadati portale (icona code point: 1F3AE = game controller)
        APP_ID      = 'kidsplay-arcade'
        APP_NAME    = 'KidsPlay Web Arcade'
        APP_DESC    = 'Raccolta di giochi web per bambini.'
        APP_CAT     = 'Games'
        APP_ICON_CP = '1F3AE'
        APP_COLOR   = '#3b82f6'
    }

    stages {
        stage('Build image') {
            steps {
                sh 'docker build -t $IMAGE .'
            }
        }

        stage('Deploy container') {
            steps {
                sh '''
                    docker rm -f $CONTAINER 2>/dev/null || true
                    docker run -d \
                        --name $CONTAINER \
                        --restart unless-stopped \
                        -p $HOST_PORT:8080 \
                        $IMAGE
                '''
            }
        }

        stage('Health check') {
            steps {
                sh '''
                    sleep 6
                    docker exec $CONTAINER python -c "import urllib.request,sys; sys.exit(0 if urllib.request.urlopen('http://localhost:8080/', timeout=10).status==200 else 1)"
                    echo "KidsPlay OK su http://192.168.1.129:8092/"
                '''
            }
        }

        stage('Register in portal') {
            steps {
                sh '''
                    docker run --rm \
                        -v /var/www/family-portal/config:/cfg \
                        -e APP_ID="$APP_ID" \
                        -e APP_NAME="$APP_NAME" \
                        -e APP_DESC="$APP_DESC" \
                        -e APP_CAT="$APP_CAT" \
                        -e APP_ICON_CP="$APP_ICON_CP" \
                        -e APP_COLOR="$APP_COLOR" \
                        -e APP_PORT="$HOST_PORT" \
                        $IMAGE python /app/portal_register.py
                '''
            }
        }
    }

    post {
        success { echo 'KidsPlay deployato e registrato: http://192.168.1.129:8092/' }
        failure { echo 'Deploy KidsPlay FALLITO. Log: docker logs kidsplay' }
    }
}
