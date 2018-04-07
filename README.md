# jupyterlab-notebook
Docker image to run [JupyterLab Notebook](http://jupyterlab.readthedocs.io/en/stable/) locally

![](jupyterlab.png)

## Introduction
Running [JupyterLab Notebook](http://jupyterlab.readthedocs.io/en/stable/) locally can be painful due to conflicts with base system Python and I don't particully like conda or venv.

I'm leveraging Docker to run a notebook locally with a bonus that allow me to have several different versions and try optimial instalations.

## Usage
The companion script `[notebook.bashrc](notebook.bashrc)` tries to load locally a image matching the file version and if it can't find it will build it automatically. Once the image is ready the notebook will start and listen on port 8888.

```bash
# Add this to your ~/.bashrc
[ -f ~/usr/local/jupyterlab-notebook/notebook.bashrc ] && source ~/usr/local/jupyterlab-notebook/notebook.bashrc
```

After loading the companion script, you can open the notebook watching to the current folder:

```bash
cd ~/Notebooks
notebook
```

## Extending
There is a [fairly amount of packages installed](requirements.txt) on this image, but you can always customize it. Edit `requirements.txt` and rebuild.

## Alternative
If you like the idea but doesn't want to build it locally, you can always [pull from DockerHub](https://hub.docker.com/r/arjones/notebook/)
