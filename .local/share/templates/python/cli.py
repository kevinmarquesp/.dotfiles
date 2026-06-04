#!/usr/bin/env python

'''[...description...]
'''

from typing import Any
from dataclasses import MISSING, dataclass, field, fields
from argparse import Namespace, ArgumentParser
from os.path import basename
from sys import argv


VERSION = '0.1.0'


def fieldx(abbr=None, default=MISSING, h=None, default_factory=MISSING,
           nargs=None, end=False) -> Any:
  return field(default=default, default_factory=default_factory,
               metadata={'abbr': abbr, 'h': h, 'nargs': nargs, 'end': end})


@dataclass
class Arguments:
  color: bool = fieldx(abbr='c', default=False,
                       h='enable colors in output')
  name: str = fieldx(abbr='n', default='World',
                     h='use a custom name in the message')
  add: list[str] = fieldx(end=True, default_factory=list, nargs='*',
                          h='additional messages')


def main(args: Arguments) -> None:
  message = f'Hello, {args.name}!'

  if args.add:
    message += ' ' + ' '.join(args.add)

  if args.color:
    message = f'\033[32m{message}\033[0m'

  print(message)


def parse(prog: str, argx: list[str]) -> Namespace:
  parser = ArgumentParser(prog=prog, description=__doc__)

  parser.add_argument('--version', '-v', action='version',
                      version=f'%(prog)s {VERSION}')

  for field in fields(Arguments):
    keys = {}

    if field.default is not MISSING:
      keys['default'] = field.default

    if field.metadata.get('h') is not None:
      keys['help'] = field.metadata.get('h')

    if field.metadata.get('nargs') is not None:
      keys['nargs'] = field.metadata.get('nargs')

    name = field.name.replace('_', '-')
    abbr = field.metadata.get('abbr')

    # the 'end' metadata separates the arguments after the '--' mark
    if field.metadata.get('end'):
      parser.add_argument(name, **keys)
      continue

    keys['action'] = 'store_true' if field.type is bool else 'store'
    params = (f'--{name}', f'-{abbr}') if abbr is not None else (f'--{name}',)

    parser.add_argument(*params, **keys)

  return parser.parse_args(argx)


if __name__ == '__main__':
  prog = basename(argv[0])
  argp = parse(prog, argv[1:])
  args = Arguments(**vars(argp))

  main(args)
