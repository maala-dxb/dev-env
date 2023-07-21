kubectl delete all  --all -n ingress-nginx
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.1/deploy/static/provider/cloud/deploy.yaml
# I'm not sure why delete webhook validation fails sometimes tbh.
# it was causing my ingress to not resolve the host but I tried
# minikube delete --all then minikube start and it worked
# kubectl delete -A ValidatingWebhookConfiguration ingress-nginx-admission
minikube addons enable ingress
minikube addons enable ingress-dns

for FILE in kube/*;
  do kubectl apply -f $FILE;
done
