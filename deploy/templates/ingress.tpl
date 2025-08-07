apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: pingdom-default-ingress
  namespace: ${NAMESPACE}
  annotations:
    external-dns.alpha.kubernetes.io/set-identifier: pingdom-default-ingress-cloud-platform-pingdom-ingress-check-prod-green
    external-dns.alpha.kubernetes.io/aws-weight: "100"
spec:
  ingressClassName: default
  tls:
    - hosts:
        - pingdom-default-ingress.apps.live.cloud-platform.service.justice.gov.uk
  rules:
    - host: pingdom-default-ingress.apps.live.cloud-platform.service.justice.gov.uk
      http:
        paths:
          - path: /
            pathType: ImplementationSpecific
            backend:
              service:
                name: cloud-platform-pingdom-default-ingress-check-service
                port:
                  number: 8080
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: pingdom-modsec-ingress
  namespace: ${NAMESPACE}
  annotations:
    external-dns.alpha.kubernetes.io/set-identifier: pingdom-modsec-ingress-cloud-platform-pingdom-ingress-check-prod-green
    external-dns.alpha.kubernetes.io/aws-weight: "100"
    nginx.ingress.kubernetes.io/enable-modsecurity: "true"
spec:
  ingressClassName: modsec
  tls:
    - hosts:
        - pingdom-modsec-ingress.apps.live.cloud-platform.service.justice.gov.uk
  rules:
    - host: pingdom-modsec-ingress.apps.live.cloud-platform.service.justice.gov.uk
      http:
        paths:
          - path: /
            pathType: ImplementationSpecific
            backend:
              service:
                name: cloud-platform-pingdom-modsec-ingress-check-service
                port:
                  number: 8080