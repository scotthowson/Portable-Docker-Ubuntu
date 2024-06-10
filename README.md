
# Ubuntu Touch Porting Environment

This repository provides a Docker-based environment for porting Ubuntu Touch. It includes all necessary dependencies and tools configured for a smooth porting experience.

## Prerequisites

- Docker
- Docker Compose

## Setup Instructions

### 1. Clone the Repository

First, clone this repository to your local machine:

```sh
git clone <repository-url>
cd <repository-directory>
```

### 2. Build the Docker Image

Use Docker Compose to build the Docker image:

```sh
docker-compose build --no-cache
```

### 3. Start the Docker Container

Start the container using Docker Compose:

```sh
docker-compose up -d
```

### 4. Access the Running Container

To interact with the container, use the following command to get a shell inside the container:

#### Using Bash

```sh
docker exec -it ubuntu-kernel-build bash
```

#### Using Zsh

```sh
docker exec -it ubuntu-kernel-build zsh
```

## Verify the Setup

Once inside the container, ensure that all necessary tools and dependencies are installed and correctly configured. You can check some key components as follows:

- **Check i386 Architecture:**
  ```sh
  dpkg --print-foreign-architectures
  ```

- **Verify \`repo\` Tool in PATH:**
  ```sh
  which repo
  ```

- **Verify GitHub SSH Key:**
  ```sh
  cat ~/.ssh/known_hosts
  ```

### Create vbmeta Image

You can create the `vbmeta.img` file using `avbtool`:

```sh
avbtool make_vbmeta_image --output vbmeta.img --flags 2
```

## Flashing Images

After building, you will need to flash the images to your device:

1. **Flash `vbmeta.img`:**
   ```sh
   fastboot flash vbmeta --disable-verity --disable-verification vbmeta ./vbmeta.img
   ```

2. **Reboot the Device:**
   ```sh
   fastboot reboot
   ```

## Additional Information

### Directory Structure

- `/avb`: Contains the cloned AVB repository.
- `~/bin`: Custom bin directory added to PATH for tools like `repo`.
- `~/.ssh/known_hosts`: Contains known hosts entries to avoid SSH verification issues with GitHub.

### Included Tools and Dependencies

The Dockerfile installs a comprehensive list of tools and dependencies needed for Ubuntu Touch porting, including but not limited to:

- `git`, `gnupg`, `flex`, `bison`, `gperf`, `build-essential`, `zip`, `bzr`, `curl`
- `libc6-dev`, `libncurses5-dev:i386`, `x11proto-core-dev`, `libx11-dev:i386`
- `libreadline6-dev:i386`, `libgl1-mesa-glx:i386`, `libgl1-mesa-dev`, `g++-multilib`
- `mingw-w64-i686-dev`, `tofrodos`, `python3-markdown`, `libxml2-utils`, `xsltproc`
- `zlib1g-dev:i386`, `schedtool`, `liblz4-tool`, `bc`, `lzop`, `imagemagick`, `libncurses5`
- `rsync`, `python-is-python3`, `python2`, `ca-certificates`, `cpio`, `sudo`, `unzip`, `wget`
- `xz-utils`, `kmod`, `libssl-dev`, `libtinfo5`, `img2simg`, `jq`, `zsh`, `neofetch`

### Customizations

- **Oh My Zsh:** Installed for an enhanced shell experience with custom plugins.
- **Known Hosts:** GitHub SSH key added to known hosts to prevent verification issues during cloning.

## License

This project is licensed under the MIT License. See the LICENSE file for details.