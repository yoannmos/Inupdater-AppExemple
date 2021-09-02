""" main test file """
import pytest

from appexemple import __version__


class TestMain:
    """Test Main"""

    def test_version(self):
        """Test pass"""
        assert __version__ == "0.1.0"
