FROM lscr.io/linuxserver/webtop:amd64-ubuntu-kde-version-0f29909a
#FROM lscr.io/linuxserver/webtop:ubuntu-xfce-version-5b58d96e

# Configure environment
ENV DOCKER_IMAGE_NAME='paraview-env'
ENV VERSION='2023-07-19' 

# title
ENV TITLE=Paraview

RUN apt-get update && \
    apt-get install -y vim git wget unzip

# ports and volumes
EXPOSE 3000

VOLUME /config

# Install ParaView

# You will need to build ParaView yourself to include python modules.
# [https://github.com/Kitware/ParaView/blob/master/Documentation/dev/build.md]

# RUN apt-get update && \
#     apt-get install -y cmake \
#                        build-essential \
#                        libgl1-mesa-dev libxt-dev \
#                        libqt5x11extras5-dev libqt5help5 qttools5-dev \
#                        qtxmlpatterns5-dev-tools libqt5svg5-dev python3-dev \
#                        python3-numpy libopenmpi-dev libtbb-dev ninja-build

# build a specific ParaView version, eg: v5.11.1
# RUN TAG="v5.11.1"&& \
#     git clone https://gitlab.kitware.com/paraview/paraview.git /config && \
#     mkdir /config/paraview_build && \
#     cd /config/paraview && \
#     git checkout $TAG && \
#     git submodule update --init --recursive

## Place the source for the plugin in a directory under ParaView/Plugins.
# meshio module
#RUN git clone https://github.com/nschloe/meshio.git /config/paraview/Plugins

#WORKDIR /config/paraview_build

#RUN cmake -GNinja -DPARAVIEW_USE_PYTHON=ON -DPARAVIEW_USE_MPI=ON -DVTK_SMP_IMPLEMENTATION_TYPE=TBB -DCMAKE_BUILD_TYPE=Release ../paraview && \
#    ninja


# ParaView-5.11.1-MPI-Linux-Python3.9-x86_64.tar.gz
RUN PARAVIEW_URL="https://www.paraview.org/paraview-downloads/download.php?submit=Download&version=v5.11&type=binary&os=Linux&downloadFile=ParaView-5.11.1-MPI-Linux-Python3.9-x86_64.tar.gz" && \
  curl -k -v -s -L $PARAVIEW_URL | tar xz -C /tmp && \
  mv /tmp/ParaView* /config/paraview

#RUN chmod 777 -R /config/slicer

COPY /desktop/paraview.desktop /usr/share/applications/
COPY /desktop/paraview.desktop /config/Desktop/
RUN chmod 777 /config/Desktop/paraview.desktop

#RUN chmod 777 -R /config/.cache
#RUN chmod 777 -R /config/.local