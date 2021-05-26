#!/usr/bin/env python3

from pathlib import Path
from setuptools import setup, find_packages

root_dir = Path(__file__).parent.resolve()
root_uri = root_dir.as_uri()

with open(root_dir / "README.md", "r", encoding="utf-8") as f:
    long_description = f.read()

setup(
    name="npview",
    version="1.0.0",
    author="Roger Qiu",
    author_email="roger@formbay.com.au",
    description="Viewing tool for numpy images",
    long_description=long_description,
    url="https://gitlab.formbay.com.au/machine-learning/npview",
    packages=find_packages(),
    entry_points={"console_scripts": ["npview=npview.__main__:main"]},
    install_requires=["numpy", "matplotlib"],
)
