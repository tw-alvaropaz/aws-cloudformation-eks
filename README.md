## AWS Cloudformation EKS

This is an example project to deploy and provisione an aws infrastructure using cloudformation and kubernetes (EKS)

---

### Requirementes

- aws user
- aws console
- kubectl (kubernetes-cli)

### First steps

In order to use the provisioning scripts you will need to configure an aws user with priveleges to manage vpc, eks, ec2, you can follow this guide to configure the user: [aws user configuration guide](https://github.com/herrera-luis/aws-cloudformation-eks/tree/main/images/aws-user)

If you have already configured an aws user you have to insert the **Access Key ID** and **Secret Access Key** values it in the aws console using the following command:

`aws configure`

### Deploying the infrastructure

In order to deploy your infrastructure execute the following script inside the **cloudformation/** folder:

    sh ./create.sh workshop-devops network_and_eks.yml network_and_eks.json

Note: The creation of EKS cluster takes almost 10 minutes

After the EKS cluster creation is success you can add EKS context in your machine with following command:

    aws --region us-west-2 eks update-kubeconfig --name workshop-devops

In order to list the nodes attached to your cluster you can use the following command:

    kubectl get nodes

### Provisioning Kubernetes

Before execute the following commands be sure that you are in the **k8s/** folder

1. Install HAProxy Ingress Controller

   `kubectl apply -f 1_haproxy-ingress.yaml`

2. Install deployment of app v1

   `kubectl apply -f 2_app-v1.yaml`

3. Install the service

   `kubectl apply -f 3_service.yaml`

4. Install the ingress

   `kubectl apply -f 4_ingress.yaml`

5. Expose ingress controller with a load balancer service

   `sh ./5_expose_url_with_load_balancer.sh`

   Then you can know the **EXTERNAL-IP** and check the application deployed in your browser with the path `/`

6. Remove the infrastructure:

   `sh ./destroy.sh workshop-devops network_and_eks.yml network_and_eks.json`

### Next steps

- Configure your pipeline
