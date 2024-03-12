# dns_resolver

Deploys Unbound resolver, unbound-exporter, and a custom DNS based blocklist
generator against Facebook all tightly knit into one Podman pod.

This role may also be used to block sites using DNS.

## Role Variables

Site blocking

To block a site, add the following to `group_vars/dns_resolver`

```
dns_resolver_domain_admin_block:
    - example.com.
```

The blocklist generator uses tag `socialmedia` by default. Include this tag in
your ACLs to block Facebook. Administrator managed blocklists are tagged with
`admin_block`.

To manage netblocks, see `group_vars/dns_resolver` `dns_resolver_access_control`
dictionary. A sample is also provided in the default variables file.

Files:
* `50-custom-block.conf.j2`
* `92-resolve-policies.conf.j2`
