#!/bin/bash

# Создание пользователей в виде ServiceAccount
kubectl create serviceaccount viewer-user
kubectl create serviceaccount configurator-user
kubectl create serviceaccount admin-user

