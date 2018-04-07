FROM python:3-slim

WORKDIR /root/notebook

# Install xvfb and doc converter
# Allowing Download As PDF
# https://nbconvert.readthedocs.io/en/latest/install.html
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    xvfb xauth \
    fonts-inconsolata python-opengl \
    fontconfig texlive-xetex texlive-fonts-recommended texlive-generic-recommended pandoc \
    build-essential wget && \
    fc-cache -fv

COPY requirements.txt /tmp
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r /tmp/requirements.txt 
    # && \ jupyter nbextension enable --sys-prefix --py vega

# Recommendation to use TINI
# http://jupyter-notebook.readthedocs.io/en/stable/public_server.html#docker-cmd
RUN wget -O /usr/bin/tini \
    https://github.com/krallin/tini/releases/download/v0.16.1/tini && \
    chmod +x /usr/bin/tini

# Clean-up
RUN dpkg -P build-essential wget && \
    rm -fr /var/lib/apt /tmp/requirements.txt

EXPOSE 8888

ENTRYPOINT ["/usr/bin/tini", "--"]

# Using only localhost
CMD xvfb-run -s "-screen 0 1400x900x24" jupyter lab --allow-root --no-browser --port=8888 --ip=0.0.0.0 --NotebookApp.token=
