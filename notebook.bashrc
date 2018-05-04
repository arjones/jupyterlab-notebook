function notebook {
  local PROJECTDIR=~/.bashrc.d/notebook
  local VERSIONFILE=${PROJECTDIR}/requirements.txt
  local VERSION=$(date -u --date="@$(stat --format=%Y ${VERSIONFILE})" +%y%m%d%H)
  # build your own image
  local IMAGE="${USER}/notebook:${VERSION}"

  # Check if image exists:
  if [ -z "$(docker images -q ${IMAGE})" ]; then
    echo "Image not found. Building image ... ${IMAGE}"
    docker build --pull --tag ${IMAGE} ${PROJECTDIR}
  fi

  docker run --rm -it \
    -p 8888:8888 \
    --name "notebook-$(basename `pwd`)" \
    -v "$(pwd):/root/notebook" \
    ${IMAGE}
}