FROM rocker/r-base:3.6.3
RUN apt-get update && apt-get install -y libcurl4-openssl-dev libxml2-dev

RUN mkdir /home/ass
COPY ./renv.lock /home/ass/renv.lock
# COPY /input_container/runASS.R /home/ass/runASS.R
# copying .Renviron file can be deleted once the repositories are public
COPY ./.Renviron /home/ass/.Renviron
WORKDIR /home/ass

RUN R -e "install.packages('renv'); \
  renv::consent(provided = TRUE); \
  renv::restore()"

# usage: docker run --user $(id -u):$(id -g) -v input_host:/input -v ouput_host:/output_container image
ENTRYPOINT Rscript /input/runASS.R /input /output