FROM amazonlinux:latest
LABEL Author = "Lekontsev Danil" Programm name = "Check" Description = "Checking file changes" .
RUN yum update
WORKDIR /usr/src/my_app_directory
COPY . .
RUN chmod +x ./myscript
CMD ["./myscript"]