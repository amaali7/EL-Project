import enum
import collections
import threading
from time import sleep
from .parser import CommandParser
from evillimiter.console.io import IO


class CommandMenu(object):
    def __init__(self):
        self.prompt = '>>> '
        self.parser = CommandParser()
        self._active = False
        self.daemon = ''
        self.limit_to = 0

    def argument_handler(self, args):
        """
        Handles command-line arguments.
        """
        pass

    def interrupt_handler(self):
        """
        Handles a keyboard interrupt in the input loop.
        """
        self.stop()
    
    def start(self):
        """
        Starts the menu input loop.
        Commands will be processed and handled.
        """
        self._active = True
        self._state_ = 0
        while self._active:
            try:
                command = ''
                # command = IO.input(self.prompt)
                if self._state_==0:
                    command = "scan"
                    self._state_ = 1
                elif self._state_ == 1:
                    if self.daemon == 'limit':
                        command = f"limit all {str(self.limit_to)}kbit"
                    elif self.daemon == 'block':
                        command = "block all"
                    self._state_ = 0
            except KeyboardInterrupt:
                self.interrupt_handler()
                break

            # split command by spaces and parse the arguments
            parsed_args = self.parser.parse(command.split())
            if parsed_args is not None:
                self.argument_handler(parsed_args)
            sleep(1)

    def stop(self):
        """
        Breaks the menu input loop
        """
        self._active = False
