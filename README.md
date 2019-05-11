docker-openvpn-client
=====================

> Complexity is the worst enemy of security.
>
> --- Bruce Schneier

A simple docker openvpn client. It opens a VPN connection and routes the traffic
of containers through the tunnel.

Usage
-----

First, start the vpn container. Your ovpn file must be available at the
`/vpn/config/config.ovpn` path in the container:

    docker run \
      --cap-add NET_ADMIN \
      --volume /home/me/vpnConfiguration/:/vpn/config \
      --name vpn

Now, use the VPN tunnel by launching a container with the `container:<vpn
container name>"`. This replaces the container's network stack with the vpn
container's network stack.

    docker run \
      --network "container:vpn" \
      -it \
      alpine

For more advanced use cases, a `docker-compose.yml` file is recommended. See the
[`examples/`][examples] folder to see how to expose a service attached to the
VPN container and how to configure a firewall so only outbound traffic to the
VPN is allowed.

[examples]: ./examples
[docker-hub]: https://cloud.docker.com/repository/docker/dheaps/openvpn-client/
