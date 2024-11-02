# Связывание пользователей с ролями
kubectl create rolebinding viewer-binding --role=viewer --serviceaccount=default:viewer-user
kubectl create rolebinding configurator-binding --role=configurator --serviceaccount=default:configurator-user
kubectl create rolebinding admin-user-binding --role=admin --serviceaccount=default:admin-user
