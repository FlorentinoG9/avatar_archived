"""
Sample test file to demonstrate pytest setup.
Replace these with your actual tests.
"""

import pytest


def test_example_passing():
    """Example of a passing test."""
    assert 1 + 1 == 2


def test_example_string():
    """Example test for string operations."""
    result = "hello world"
    assert "hello" in result
    assert result.upper() == "HELLO WORLD"


def test_example_list():
    """Example test for list operations."""
    my_list = [1, 2, 3, 4, 5]
    assert len(my_list) == 5
    assert 3 in my_list
    assert my_list[0] == 1


class TestExampleClass:
    """Example test class."""

    def test_addition(self):
        """Test addition operation."""
        assert 2 + 2 == 4

    def test_subtraction(self):
        """Test subtraction operation."""
        assert 5 - 3 == 2


@pytest.fixture
def sample_data():
    """Example fixture providing sample data."""
    return {"name": "Test", "value": 42}


def test_with_fixture(sample_data):
    """Example test using a fixture."""
    assert sample_data["name"] == "Test"
    assert sample_data["value"] == 42


@pytest.mark.parametrize(
    "input_value,expected",
    [
        (1, 2),
        (2, 3),
        (3, 4),
    ],
)
def test_parametrized(input_value, expected):
    """Example of parametrized test."""
    assert input_value + 1 == expected
