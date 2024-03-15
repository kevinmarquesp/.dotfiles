#!/usr/bin/env python3

from sys import argv
from argparse import ArgumentParser

from argparse import Namespace

DEFAULT_SYMLNKMAP_FILE: str = "assets/Mapper.jsonc"


class UDotArgs_co(Namespace):
    """
    Argument types for the `udot.py` script. It does nothing pratical, just helps your LSP to know what attributes it
    should expect from the returned `Namespace` object from the `parser.parse_args()` function.

    #### See Also
    + [More details about this name convention](https://peps.python.org/pep-0008/#class-names)
    + [How typehint and LSP works with that](https://docs.python.org/3/library/typing.html)
    """
    mapper: str


def udot_parser(user_args: list[str]) -> UDotArgs_co:
    """
    Argument parser for the `udot.py` command. This function will return a `UDotArgs_co` object that have the keys &
    values of the user arguments string provided, allowing you to change the behavior of the of the script as you code.

    #### Arguments List
    + `user_args`: List of the user arguments provided, normally you can get if rom `sys.argv[1:]`. That `[1:]` just
      removes the file name from that list.

    #### See Also
    + [Argparse official documentation](https://docs.python.org/3/library/argparse.html)
    + [Quick Youtube tutorial about parsing arguments](https://www.youtube.com/watch?v=88pl8TuuKz0)
    """
    parser: ArgumentParser = ArgumentParser(user_args, description="This script is a linker helper, but it also provide\
                                            som extra options, such as selecting which files you want to implement in\
                                            your system, if you want to copy the files instead of symlink and roll back\
                                            previeous configuration if you didn't liked my config!")

    parser.add_argument("-m", "--mapper", type=str, nargs=1, default=DEFAULT_SYMLNKMAP_FILE, help="Path to a mapper\
                        JSON file, with the information to create the symbolic links or copy the source files.")
    parser.add_argument("-e", "--exclude", type=list[str], nargs="*", default=[], help="List of groups that you don't\
                        want to be implemented in your system.")
    #todo: add a --include option...
    #todo: add a --match option...
    #todo: add a --skip-deps option...
    #todo: add a --skip-impl option...
    #todo: add a --copy option...
    #todo: add a --rollback option...

    return parser.parse_args()


def main(user_args: list[str]) -> None:
    args: UDotArgs_co = udot_parser(user_args)
    
    print("\nThis script is not done yet! Come back later")
    print("\033[30mUser arguments:", args, "\033[m\n")


if __name__ == "__main__":
    main(argv[1:])