# Getting Started Deploy App Using Docker And Kubernetes


#Install Minikube in Local
brew install minikube

#If Docker for Desktop is installed, you already have HyperKit

If we want to validate the state of Kubernetes resources in our cluster, we can use Kubernetes Dashboard; 
the command is “minikube dashboard.” A web browser will be opened with the following dashboard:



# once kubectl is running: Execute
kubectl cluster-info
Kubernetes master is running at https://192.168.64.2:8443
KubeDNS is running at https://192.168.64.2:8443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

#It is important to clarify that Minikube only has one cluster with its respective node. 
kubectl get nodes
NAME       STATUS   ROLES    AGE   VERSION
minikube   Ready    master   13m   v1.17.3

For this post, we only need a master node, but obviously in production mode we would probably have to use at 
least three nodes: one for the master, and two nodes for all the things related to application redundancy.

In order to create a Kubernetes Deployment, you should run the following command:

The command “kubectl run” only needs the {DEPLOYMENT_NAME} to work, 
but if you want to pull a Docker image inside this deployment, you should use the “–image” option, 
with which you can specify the Docker image to be used.
#sudo kubectl run {DEPLOYMENT_NAME} --image= {YOUR_IMAGE} --port=8080
! sudo kubectl run mykubernetes-springboot --image=justacoder7/dockerkubernetesapp:0.0.1-SNAPSHOT --port=8080

You can check the deployment that we created by using the command:

sudo kubectl get deployments
The console output should look like this:

NAME                      DESIRED   CURRENT   UP-TO-DATE   
mykubernetes-springboot   1         1         1

Congratulations, you now have a Deployment containing a Pod that is running the Spring Boot application! Kubernetes created a Deployment and a Pod for us; now we need to know the name of our Pod. To do so, you can use the following command:

!sudo kubectl get pods
The console output will be:

NAME                                                                          READY     STATUS    
mykubernetes-springboot-6f8558698d-k4ns7     1/1           Running

Currently, our application isn’t accessible from outside the cluster; it is only running on the Kubernetes cluster.  
We need to create a “bridge” between our application and the outside world, something that can be done by using a 
service. Let’s go ahead and create our service, because we want everyone to be able to use our application:

! kubectl expose deployment/mykubernetes-springboot --type="NodePort" --port 8080
// Keep It 8080 Only. Otherwise Creating Issues

The logic behind the above command is the following: we want to expose our deployment to the world through the 
NodePort (which will be assigned when the service is created). After you execute the command, a console message 
will appear:  “service ‘mykubernetes-springboot’ exposed,” which means that the application can be accessed from 
outside the cluster. We now need to know the NodePort of the service that was created. 
To do this, in addition to obtaining more details about our service, we can use the following command:

! kubectl describe services/mykubernetes-springboot

Name:                     mykubernetes-springboot
Namespace:                default
Labels:                   run=mykubernetes-springboot
Annotations:              <none>
Selector:                 run=mykubernetes-springboot
Type:                     NodePort
IP:                       10.109.185.97
Port:                     <unset> 8080/TCP
TargetPort:               8080/TCP
NodePort:                 <unset> 30961/TCP
Endpoints:                172.17.0.3:8080
Session Affinity:         None
External Traffic Policy:  Cluster
Events:                   <none>

It is time to access our application. Remember that the application lives inside a Pod, 
and we’ve created a service that allows us to access the application from outside the cluster. 
Use the following command to see which Minikube IP you have:

! minikube ip

In my case, the IP is http://192.168.99.100/ and the NodePort is 30961. 
Go to your favorite browser and type:  http://192.168.99.100:30961/hello. You can see that 
the application is running and can be accessed from outside the Kubernetes cluster:

//// Drone integration