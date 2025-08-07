apiVersion: apps/v1
kind: Deployment
metadata:
  name: cloud-platform-pingdom-default-ingress-check-deployment
  namespace: ${REGISTRY}/${REPOSITORY}:${IMAGE_TAG}
spec:
  replicas: 2
  selector:
    matchLabels:
      app: pingdom-default-ingress
  template:
    metadata:
      labels:
        app: pingdom-default-ingress
        app.kubernetes.io/name: cloud-platform-pingdom-default-ingress-check
    spec:
      containers:
        - name: pingdom-default-ingress
          image: ${REGISTRY}/${REPOSITORY}:${IMAGE_TAG}
          ports:
            - containerPort: 8080
          securityContext:
            runAsNonRoot: true
            allowPrivilegeEscalation: false
            seccompProfile:
              type: RuntimeDefault
            capabilities:
              drop:
                - ALL
          env:
            - name: GIN_MODE
              value: "release"
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: cloud-platform-pingdom-modsec-ingress-check-deployment
  namespace: ${NAMESPACE}
spec:
  replicas: 2
  selector:
    matchLabels:
      app: pingdom-modsec-ingress
  template:
    metadata:
      labels:
        app: pingdom-modsec-ingress
        app.kubernetes.io/name: cloud-platform-pingdom-modsec-ingress-check
    spec:
      containers:
        - name: pingdom-modsec-ingress
          image: ${REGISTRY}/${REPOSITORY}:${IMAGE_TAG}
          ports:
            - containerPort: 8080
          securityContext:
            runAsNonRoot: true
            allowPrivilegeEscalation: false
            seccompProfile:
              type: RuntimeDefault
            capabilities:
              drop:
                - ALL
          env:
            - name: GIN_MODE
              value: "release"