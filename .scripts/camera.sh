#!/bin/bash

ffplay -window_title Webcam -fast /dev/video0

trap 'kill 0' SIGINT
