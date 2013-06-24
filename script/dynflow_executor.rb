#!/bin/bash

# Runs the steps sent to queue
rails runner 'Katello::Bus.messaged.subscribe_executor'
