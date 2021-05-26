import sys
import os
import argparse
import logging
import contextlib
import numpy as np
import matplotlib.pyplot as plt
from pathlib import Path


def verbose_to_loglevel(c: int) -> int:
    loglevel = logging.WARNING
    if c == 1:
        loglevel = logging.INFO
    elif c >= 2:
        loglevel = logging.DEBUG
    return loglevel


@contextlib.contextmanager
def figure(*args, **kwargs):
    fig = plt.figure(*args, **kwargs)
    yield fig
    plt.close(fig)


def main(args=sys.argv[1:]):
    options_parser = argparse.ArgumentParser()
    options_parser.add_argument("target")
    options_parser.add_argument(
        "-v", "--verbose", help="Log Verbose Messages", action="count", default=0
    )
    options = options_parser.parse_args(args)
    logging.basicConfig(level=verbose_to_loglevel(options.verbose))
    logger = logging.getLogger(__name__)
    path = Path(options.target)
    if path.is_file():
        image_paths = [path]
    elif path.is_dir():
        image_paths = (entry.path for entry in os.scandir(path) if entry.is_file())
    else:
        raise ValueError("target must be a file or directory")

    for image_path in image_paths:
        with figure() as fig:
            ax = fig.add_subplot(1, 1, 1)
            try:
                image = np.load(image_path)
            except OSError:
                continue
            logger.info("Showing {}".format(image_path))
            ax.imshow(image)
            plt.show()


if __name__ == "__main__":
    main()
