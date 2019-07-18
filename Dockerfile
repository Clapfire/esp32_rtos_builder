FROM ubuntu:latest AS espbuilder

#Add new user
RUN adduser --disabled-password --gecos "" espbuilder && usermod -aG sudo espbuilder
#Install required packages
RUN apt-get update && \
    apt-get install -y\
    gcc git wget make libncurses-dev flex bison gperf python python-serial
#Switch to user and home directory
USER espbuilder
WORKDIR /home/espbuilder
#Install toolchain
RUN wget https://dl.espressif.com/dl/xtensa-esp32-elf-linux64-1.22.0-80-g6c4433a-5.2.0.tar.gz && \
    tar -xzf xtensa-esp32-elf-linux64-1.22.0-80-g6c4433a-5.2.0.tar.gz && \
    rm xtensa-esp32-elf-linux64-1.22.0-80-g6c4433a-5.2.0.tar.gz

#Add toolchain to path
ENV PATH "$PATH:/home/espbuilder/xtensa-esp32-elf"
#Fetch SDK
RUN git clone -b release/v3.3 --recursive https://github.com/espressif/esp-idf.git
#Add SDK to IDF_PATH
ENV IDF_PATH "/home/espbuilder/esp-idf"