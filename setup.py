#!/usr/bin/env python3

from setuptools import setup, find_packages

with open('README.md', 'r') as f:
    long_description = f.read()

setup(
    name='npview',
    version='0.0.1',
    author='Roger Qiu',
    author_email='roger@formbay.com.au',
    description=
    'Viewing tool for numpy images',
    long_description=long_description,
    url='https://gitlab.formbay.com.au/machine-learning/npview',
    packages=find_packages(),
    scripts=['bin/npview'],
    install_requires=['numpy', 'matplotlib'])
