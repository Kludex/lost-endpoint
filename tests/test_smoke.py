import inspect

import lost_endpoint


def test_smoke():
    assert inspect.ismodule(lost_endpoint)
