# update system
apt-get update
apt-get upgrade -y
# install Linux tools and Python 3
apt-get install software-properties-common wget curl \
    python3-dev python3-pip python3-wheel python3-setuptools -y
# install Python packages
curl -LsSf https://astral.sh/uv/install.sh | sh
uv pip install --user -r .devcontainer/requirements.txt
# update CUDA Linux GPG repository key
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/cuda-keyring_1.1-1_all.deb
dpkg -i cuda-keyring_1.1-1_all.deb
rm cuda-keyring_1.1-1_all.deb
# stuff that handles the nvidia keyring
sed -i '/developer\.download\.nvidia\.com\/compute\/cuda\/repos/d' /etc/apt/sources.list.d/*
sed -i '/developer\.download\.nvidia\.com\/compute\/machine-learning\/repos/d' /etc/apt/sources.list.d/*
# install recommended packages
apt-get install zlib1g g++ freeglut3-dev git \
    libx11-dev libxmu-dev libxi-dev libglu1-mesa libglu1-mesa-dev libfreeimage-dev -y
# clean up
uv pip cache purge
apt-get autoremove -y
apt-get clean
# fun stuff for me 
curl -sS https://starship.rs/install.sh | sh
echo $'eval "$(starship init bash)"' >> /root/.bashrc
starship preset pure-preset -o ~/.config/starship.toml