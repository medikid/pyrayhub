#!/bin/bash

ray stop
ray start --address='192.168.0.111' --redis-port='8888' --redis-password='janashakthi'