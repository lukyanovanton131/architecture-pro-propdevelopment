#!/bin/bash
kubectl apply -f Namespaces.yaml
kubectl apply -f Users.yaml
kubectl apply -f Roles.yaml
kubectl apply -f RolesBindings.yaml