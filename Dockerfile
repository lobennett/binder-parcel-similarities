FROM ghcr.io/lobennett/poldrack_fmri:latest

# Set up arguments and environment variables for the new user
ARG NB_USER
ARG NB_UID
ENV USER=${NB_USER}
ENV HOME=/home/${NB_USER}

# Create the user with a home directory
RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

# Copy all files from the repository into the user's home directory
COPY . ${HOME}

# Change the ownership of the copied files to the new user.
# Must be done as root 
RUN chown -R ${NB_UID} ${HOME}

# Set the working directory to the user's home
WORKDIR ${HOME}

# Switch to the non-root user
USER ${USER}