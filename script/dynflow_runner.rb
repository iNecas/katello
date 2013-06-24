#!/bin/bash

# Listens for new execution plans and distributes the messages for the steps
rails runner 'Katello::Bus.messaged.subscribe_runner'
