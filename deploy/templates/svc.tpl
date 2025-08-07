apiVersion: v1
kind: Service
metadata:
  name: cloud-platform-pingdom-default-ingress-check-service
  namespace: ${NAMESPACE}
spec:
  selector:
    app: pingdom-default-ingress
  ports:
    - protocol: TCP
      port: 8080
      targetPort: 8080
  type: ClusterIP
---
apiVersion: v1
kind: Service
metadata:
  name: cloud-platform-pingdom-modsec-ingress-check-service
  namespace: ${NAMESPACE}
spec:
  selector:
    app: pingdom-modsec-ingress
  ports:
    - protocol: TCP
      port: 8080
      targetPort: 8080
  type: ClusterIP