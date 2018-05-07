#!/bin/bash -e

# clone the webthing-tester
git clone https://github.com/mozilla-iot/webthing-tester
pip install -r webthing-tester/requirements.txt

# build and test the single-thing example
PYTHONPATH=. python example/single-thing.py &
EXAMPLE_PID=$!
sleep 5
./webthing-tester/test-client.py
kill -15 $EXAMPLE_PID

# build and test the multiple-things example
PYTHONPATH=. python example/multiple-things.py &
EXAMPLE_PID=$!
sleep 5
./webthing-tester/test-client.py --path-prefix "/0"
kill -15 $EXAMPLE_PID
