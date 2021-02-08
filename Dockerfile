FROM gcr.io/deepnote-200602/templates/deepnote

# python env
RUN pip install plotly h5py matplotlib numpy pandas astropy jupyter
RUN pip install pyaml pandeia.engine jwst sep stwcs
RUN pip install peakutils shapely pyregion drizzlepac

# Own repositories
RUN git clone https://github.com/gbrammer/eazy-py.git --recurse-submodules
RUN cd eazy-py && pip install . 

RUN git clone https://github.com/gbrammer/grizli.git --recurse-submodules
RUN cd grizli && pip install .  

RUN git clone https://github.com/gbrammer/tristars.git 
RUN cd tristars && pip install .  

RUN git clone https://github.com/gbrammer/mastquery.git
RUN cd mastquery && pip install .  

RUN pip install git+https://github.com/bd-j/sedpy.git
RUN pip install git+https://github.com/bd-j/prospector.git

# Fork from karllark
RUN pip install git+https://github.com/gbrammer/dust_attenuation.git
RUN pip install git+https://github.com/karllark/dust_extinction.git

RUN pip install sqlalchemy
RUN pip install psycopg2-binary
RUN pip install tqdm

# FSPS
RUN sudo apt-get update
RUN sudo apt-get install -y less gfortran

RUN git clone https://github.com/cconroy20/fsps.git
RUN cd fsps/src && make

ENV SPS_HOME ${HOME}/fsps/
RUN pip install git+https://github.com/gbrammer/python-fsps.git

# GALFIT
RUN sudo apt-get install -y libncurses5
RUN wget https://users.obs.carnegiescience.edu/peng/work/galfit/galfit3-debian64.tar.gz
RUN tar xzvf galfit3-debian64.tar.gz && tar xzvf galfit3-debian64.tar.gz galfit && sudo mv galfit /usr/local/bin/
