docker-stunnel
=====================

> Complexity is the worst enemy of security.
>
> --- Bruce Schneier

A simple docker SSL tunnel client. It opens an stunnel connection and routes the traffic
of containers through the tunnel.

Usage
-----

First, start the stunnel container. Your ssl and crt file must be available at the
`/stunnel/config/config.ssl` path in the container:

    docker run \
      --cap-add NET_ADMIN \
      --volume /home/me/stunnelConfiguration/:/stunnel/config \
      --name stunnel dheaps/stunnel:latest

Now, use the SSL tunnel by launching a container with the `container:<stunnel
container name>"`. This replaces the container's network stack with the stunnel
container's network stack.

    docker run \
      --network "container:stunnel" \
      -it \
      alpine

For more advanced use cases, a `docker-compose.yml` file is recommended. See the
[`examples/`][examples] folder to see how to expose a service attached to the
SSL tunnel container and how to configure a firewall so only outbound traffic through 
the tunnel is allowed.

[examples]: ./examples
[docker-hub]: https://cloud.docker.com/repository/docker/dheaps/stunnel/
