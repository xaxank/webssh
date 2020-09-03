__author__ = 'xsank'

import re
import sys
import requests

_PLATFORM = sys.platform


def check_ip(ip):
    pattern = re.compile(
        '^((25[0-5]|2[0-4]\d|[01]?\d\d?)\.){3}(25[0-5]|2[0-4]\d|[01]?\d\d?)$')
    return True if pattern.match(ip) else False


def check_port(port):
    if port and port.isdigit():
        iport = int(port)
        return 0 < iport < 65536
    return False

def validateUser(token):
    if token:
        auth_response = requests.get('https://wattman.zenatix.com/validate_jwt/?token={}'.format(token))
        response_dict = auth_response.json()
        if response_dict.get("user_id") is not None:
            return True
        return False
    return False

class Platform(object):

    @staticmethod
    def detail():
        return _PLATFORM

    @staticmethod
    def is_win():
        return _PLATFORM.startswith('win')

    @staticmethod
    def is_linux():
        return _PLATFORM.startswith('linux')

    @staticmethod
    def is_mac():
        return _PLATFORM.startswith('darwin')
