# Use the current version of Amazon Linux used in Lambda Deployment
FROM amazonlinux:2017.03

# Update yum for Python36
RUN yum update -y

# Install Build Tools
RUN yum install -y gcc gcc-c++ make zip wget python36 python36-devel bzip2 tar swig findutils python3-pip

# Setup the Build Path
RUN mkdir /geos
WORKDIR /geos

# Download Libgeos source file
RUN wget http://download.osgeo.org/geos/geos-3.7.1.tar.bz2

RUN tar xvfj geos-3.7.1.tar.bz2
WORKDIR geos-3.7.1

# PYTHON environment variable is detected by the libgeos ./configure script
ENV PYTHON=/usr/bin/python3.6m

# Python3.6 installs a build using pymalloc, which is not detected by libgeos configure script
RUN ln /usr/lib64/libpython3.6m.so /usr/lib64/libpython3.6.so

# Configure and install
RUN ./configure --enable-python --prefix=/opt --enable-shared
RUN make && make install

# Build Python Layer
RUN mkdir /shapely
WORKDIR /shapely
COPY requirements.txt /shapely
RUN pip3 install -r requirements.txt --install-option="--prefix=/shapely" --ignore-installed
RUN mkdir python && mv lib python && zip -r python-dependencies.zip python -x

# Copy in the entrypoint script
COPY entrypoint.sh /geos
ENTRYPOINT [ "sh", "-c", "/geos/entrypoint.sh" ]
