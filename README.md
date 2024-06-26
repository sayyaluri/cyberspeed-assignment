# cyberspeed
Cyberspeed DevOps Assignment 

# three-tier-eks-iac

![image](https://github.com/sayyaluri/cyberspeed-assignment/assets/32944930/e4fcc461-054e-43cd-851a-95f2dc8e4d24)


# Prerequisite 

**Install Kubectl**
https://kubernetes.io/docs/tasks/tools/

**Install Helm**
https://helm.sh/docs/intro/install/

**Install latest AWS CLI:**
https://aws.amazon.com/cli/

**Install terraform CLI**

# Create IAM User/role 
create IAM User with privileged access to deploy eks cluster and related service. or

# Deploy EKS cluster:
via terraform cli

 ```
 git clone https://github.com/sayyaluri/cyberspeed-assignment.git
 cd iac_terraform
 terraform init
 terraform validate
 terrafrm plan
 terraform apply
 ```

# Build Docker image :

Build Front End :

```
docker build -t cyberspeed-frontend:v1 . 
docker tag cyberspeed-frontend:v1 public.ecr.aws/w8u5e4v2/cyberspeed-frontend:v1
docker push public.ecr.aws/w8u5e4v2/cyberspeed-frontend:v1
```


Build Back End :

```
docker build -t cyberspeed-backend:v1 . 
docker tag cyberspeed-backend:v1 public.ecr.aws/w8u5e4v2/cyberspeed-backend:v1
docker push public.ecr.aws/w8u5e4v2/cyberspeed-backend:v1
```

**Update Kubeconfig**
Syntax: aws eks update-kubeconfig --region region-code --name your-cluster-name
```
aws eks update-kubeconfig --region us-west-2 --name cyberspeed-cluster
```


**Create Namespace**
```
kubectl create ns cyberspeed

kubectl config set-context --current --namespace cyberspeed
```

# MongoDB Database Setup

**To create MongoDB Resources**
```
cd kubernetes_manifests/mongo
kubectl apply -f secrets.yaml
kubectl apply -f deploy.yaml
kubectl apply -f service.yaml
```

# Backend API Setup

Create NodeJs API deployment by running the following command:
```
kubectl apply -f backend-deployment.yaml
kubectl apply -f backend-service.yaml
```

**Frontend setup**

Create the Frontend  resource. In the terminal run the following command:
```
kubectl apply -f frontend-deployment.yaml
kubectl apply -f frontend-service.yaml
```

Create the load balancer to allow internet traffic:
```
kubectl apply -f full_stack_lb.yaml
```


# Grafana setup 

**Verify Services**
```
kubectl get svc -n prometheus
```

**edit the Prometheus-grafana service:**
```
kubectl edit svc prometheus-grafana -n prometheus
```

**change ‘type: ClusterIP’ to 'LoadBalancer'**

Username: admin
Password: prom-operator


Import Dashboard ID: 1860


# Destroy Kubernetes resources and cluster
```
cd ./k8s_manifests
kubectl delete -f -f
```
**Remove AWS Resources to stop billing**
```
cd terraform
terraform destroy --auto-approve
```



