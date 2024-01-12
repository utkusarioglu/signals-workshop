$CONTAINER_REPO_PATH = '/utkusarioglu-com/workshops/signals-workshop'
$DISTRO_NAME = 'u-Boulanger'
$SERVER_PORT = 5000

function Start-OscServer {
  Set-WslProxy -Distro $DISTRO_NAME -Port $SERVER_PORT
  Write-Host "Dont't forget to remove the wsl proxy once the run is terminated"

  docker -c ${DISTRO_NAME} exec -it 'docker-signals-workshop-1' `
    bash -c "cd ${CONTAINER_REPO_PATH} && scripts/start-osc-server.sh"
}