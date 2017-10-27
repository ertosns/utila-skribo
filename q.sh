#!/bin/bash

$@ &>/dev/null &
echo $@
