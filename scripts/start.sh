#!/bin/bash
pip install -r requirements.txt
python3 ./get_secrets.py
while read p; do
  export "$p"
done <./.env
"echo xd"