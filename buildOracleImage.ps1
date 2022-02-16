Set-StrictMode -version Latest

$ORACLE_IMAGE_TAG = "oracle/database"
$ORACLE_VERSION = "18.4.0"
$ORACLE_REPO = "https://github.com/oracle/docker-images.git"
$ORACLE_DOCKER = "\OracleDatabase\SingleInstance\dockerfiles"
$TMP_PREFIX = "_oracle-docker_"
$TMP_DIR = '{0}{1}' -f $TMP_PREFIX,[IO.Path]::GetRandomFileName()

# Check that image is exist in docker
function CheckImageExists {
  $imageId = (Invoke-Expression "docker images -q $ORACLE_IMAGE_TAG") 2>&1

  if($null -ne $imageId) {
    Write-Host "Image is already exists."
    Break
  }
}

# Cleanup after build
function CleanupFiles($step) {
  Write-Host "[$step] Start cleanup."

  foreach ($folder in Get-ChildItem "$env:TEMP\$TMP_PREFIX*") {
    Remove-Item -Recurse -Force $folder
  }

  Write-Host "Done."
}

# Process new docker image
function BuildDockerImage($step) {
  Write-Host "[$step] Start image building."

  Push-Location "$env:TEMP\$TMP_DIR\$ORACLE_DOCKER"
  $process = Start-Process -FilePath "bash.exe" -ArgumentList "./buildContainerImage.sh -x -v $ORACLE_VERSION -t $ORACLE_IMAGE_TAG" -PassThru -Wait -NoNewWindow
  Pop-Location

  if ($process.ExitCode) {
    Write-Error "Unable to build oracle image."
  }
}

# Cloning docker image builder tools
function CloneRepo($step) {
  Write-Host "[$step] Start cloning oracle image builder."

  Invoke-Expression "git clone $ORACLE_REPO $env:TEMP\$TMP_DIR"

  if ($lastexitcode) {
    Write-Error "Unable to clone repository." -ErrorAction Stop
  }
}

# Entry point
CheckImageExists

# Build steps
CloneRepo "1/3"
BuildDockerImage "2/3"
CleanupFiles "3/3"