function notebook {
  local DOCKERFILE=~/.bashrc.d/notebook/Dockerfile
  local DOCKERFILEDIR=$(dirname $DOCKERFILE)
  local VERSION=$(date -u --date="@$(stat --format=%Y ${DOCKERFILE})" +%y%m%d%H)
  local IMAGE="${USER}/notebook:${VERSION}"

  # Check if image exists:
  if [ -z "$(docker images -q ${IMAGE})" ]; then
    echo "Image not found. Building image ... ${IMAGE}"
    docker build --pull --tag ${IMAGE} ${DOCKERFILEDIR}
  fi

  docker run --rm -it \
    -p 8888:8888 \
    --name "notebook-$(basename `pwd`)" \
    -v "$(pwd):/root/notebook" \
    ${IMAGE}
}