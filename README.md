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
