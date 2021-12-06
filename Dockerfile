# set base image (host OS)
FROM ubuntu:latest

# set the working directory in the container
WORKDIR /photo-sorter

# copy the content of the local src directory to the working directory
COPY . .

# command to run on container start
CMD [ "./run.sh" ]
# comment CMD and uncomment below for debugging
#ENTRYPOINT ["tail", "-f", "/dev/null"]
