# Tailscale in LXD containers

## Prerequisite

To run this tutorial, you will need the following software installed and
configured:

- [LXD][1]
- [Terraform][2]
- [Tailscale][3]

## Getting Started

To provision your machine automatically, you need to create an reusable [auth
key][4] for the devices. This auth key will be used as an input to terraform so
that terraform can deploy the container with tailscale installed and added to
your tailscale domain automatically.

To initialize `terraform`, run:

```shell
terraform init
```

To provision 3 containers with tailscale, run

```shell
export AUTH_KEY=<auth key from tailscale>
terraform apply -var num=3 -var auth_key=${AUTH_KEY} -var-file flavors/m1.small
```

To verify the 3 containers are deployed successfully, run

```shell
lxc list # you should see 3 containers show up with tailscale0 interface
tailscale status # you should see 3 containers show up and prefixed with "runner-"
```

## Cleanup Environment

```shell
terraform apply --destroy -var auth_key=${AUTH_KEY}
```

[1]: https://documentation.ubuntu.com/lxd/en/latest/
[2]: https://registry.terraform.io/
[3]: https://tailscale.com/
[4]: https://tailscale.com/kb/1085/auth-keys
