#!/bin/bash
echo "---installing pre-commit---"
# pre commit
sudo ln -fsn /opt/python/3.8.3/bin/python3 /usr/bin/python
sudo ln -fsn /opt/python/3.8.3/bin/pip3 /usr/bin/pip
pip3 install --upgrade pip setuptools wheel
pip3 install pre-commit
pre-commit install
echo "---pre-commit done---"
