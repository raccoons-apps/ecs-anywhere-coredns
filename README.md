# Corporate CoreDNS

This repository contains the DNS resolution configuration for corporate
resources. DNS resolution is performed using [CoreDNS](https://coredns.io/)
deployed in multiple instances on different hosts. To manage DNS records, use
[route53](https://coredns.io/plugins/route53/) plugin, which synchronizes
records from AWS Route53 hosted zones.

> [!WARNING]
> This service is critical because it not only resolves DNS for internal
> services, but also resolves all public DNS queries from workstations. Public
> DNS requests are forwarded through Cloudflare and Google DoT (DNS over TLS)
> servers, so unencrypted DNS queries from workstations are relatively secure.

## Easy Installation
To start CoreDNS service on the Docker host, run the command:

> [!NOTE]
> Replace the environment variable values ​​before running the command. Note
> that the CoreDNS configuration synchronizes records with Route53 for two
> hosted zones - one for corporate resources, the other for internal resources
> accessible only to administrators.

```
docker run -d --restart=unless-stopped \
  -e COREDNS_HOSTEDZONE=example.local \
  -e COREDNS_HOSTEDZONE_ID=Z0000000001 \
  -e COREDNS_HOSTEDZONE_ACL_SUBNETS=10.0.1.0/24 \
  -e COREDNS_CLOUD_HOSTEDZONE=cloud.local \
  -e COREDNS_CLOUD_HOSTEDZONE_ID=Z0000000002 \
  -e COREDNS_CLOUD_HOSTEDZONE_ACL_SUBNETS=10.0.2.0/24 ghcr.io/raccoons-apps/ecs-anywhere-coredns:latest
```

## Installation using Amazon ECS Console
To run CoreDNS service on Amazon ECS Anywhere hosts using Amazon ECS Console,
you must first create a task definition. Below is the task definition in JSON
format to use the latest version. After creating a task definition, run it as
a service in ECS cluster with external instances.

```JSON
{
    "family": "ecs-anywhere-coredns",
    "containerDefinitions": [
        {
            "name": "container",
            "image": "ghcr.io/raccoons-apps/ecs-anywhere-coredns:latest",
            "environment": [
                {
                    "name": "COREDNS_HOSTEDZONE",
                    "value": "example.local"
                },
                {
                    "name": "COREDNS_HOSTEDZONE_ID",
                    "value": "Z0000000001"
                },
                {
                    "name": "COREDNS_HOSTEDZONE_ACL_SUBNETS",
                    "value": "10.0.1.0/24"
                },
                {
                    "name": "COREDNS_HOSTEDZONE",
                    "value": "cloud.local"
                },
                {
                    "name": "COREDNS_HOSTEDZONE",
                    "value": "Z0000000002"
                },
                {
                    "name": "COREDNS_HOSTEDZONE",
                    "value": "10.0.2.0/24"
                }
            ],
            "portMappings": [
                {
                    "containerPort": 53,
                    "hostPort": 53,
                    "protocol": "udp"
                }
            ]
        }
    ],
    "networkMode": "host",
    "cpu": "512",
    "memory": "128"
}
```
