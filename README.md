# Oracle 18c XE docker image build automotion
Simple PowerShell pipeline for Docker [single instance](https://github.com/oracle/docker-images/tree/main/OracleDatabase/SingleInstance) image from Oracle.

## Requirements
- [WSL](https://docs.microsoft.com/en-us/windows/wsl/install) - WSL enabled, and bash.exe is available
- [Docker](https://www.docker.com/get-started) - Docker for windows
- [Git](https://git-scm.com/book/en/v2) - Git installed

## Configuration
  Acceptable parameters for [buildContainerImage.sh](https://github.com/oracle/docker-images/blob/main/OracleDatabase/SingleInstance/dockerfiles/buildContainerImage.sh) script.

    -v ($ORACLE_VERSION): version to build
        Choose one of: 11.2.0.2  12.1.0.2  12.2.0.1  18.3.0  18.4.0  19.3.0  21.3.0
    -t ($ORACLE_IMAGE_TAG): image_name: tag for the generated docker image

    ...
    $ORACLE_VERSION = "18.4.0"
    $ORACLE_IMAGE_TAG = "oracle/database"
    ...