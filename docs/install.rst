
Installation
==================

Short description
----------------

BLAH

Installation
----------------

1. Install required packages (see `requirements.txt`).

Via pip or conda, e.g.,

.. code-block:: bash

    pip install -r requirements.txt

2. Compile cython code and install module.

.. code-block:: bash

    python setup.py build_ext --inplace
    python setup.py install

4. Run the tests. Nothing should fail!

.. code-block:: bash

    coverage run --source delight -m py.test

Getting Started
----------------

BLAH
