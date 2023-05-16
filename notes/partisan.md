# Partisan 

## Configuration
```erlang
    {partisan, [
        {name, 'node1@127.0.0.1'},
        {peer_port, ${PARTISAN_PEER_PORT}},
        {peer_service_manager, partisan_hyparview_peer_service_manager},
        {hyparview, [
            {active_max_size, 2},
            {active_min_size, 2},
            {passive_max_size, 20}
        ]},
        {remote_ref_format, improper_list},
        {tls, true},
        {tls_server_options, [
            {certfile, "config/_ssl/server/keycert.pem"},
            {cacertfile, "config/_ssl/server/cacerts.pem"},
            {keyfile, "config/_ssl/server/key.pem"},
            {verify, verify_none}
        ]},
        {tls_client_options, [
            {certfile, "config/_ssl/client/keycert.pem"},
            {cacertfile, "config/_ssl/client/cacerts.pem"},
            {keyfile, "config/_ssl/client/key.pem"},
            {verify, verify_none}
        ]},
        {peer_discovery, #{
            enabled => true,
            type => partisan_peer_discovery_list,
            initial_delay => 5000,
            polling_interval => 30000,
            timeout => 5000,
            config => #{
                addresses => [
                    {'node1@127.0.0.1', 10100},
                    {'node2@127.0.0.1', 10200},
                    {'node3@127.0.0.1', 10300}
                ]
            }
        }}
    ]}
```

## DEV

### Local
Start a cluster using the following commands in three different terminals

```bash
PARTISAN_NODENAME=node1@127.0.0.1 \
PARTISAN_PEER_PORT=10001 \
PORT=4001 \
PROXY_PORT=7654 \
iex -S mix
```

```bash
PARTISAN_NODENAME=node2@127.0.0.1 \
PARTISAN_PEER_PORT=10002 \
PORT=4002 \
PROXY_PORT=7655 \
iex -S mix
```

```bash
PARTISAN_NODENAME=node3@127.0.0.1 \
PARTISAN_PEER_PORT=10003 \
PORT=4003 \
PROXY_PORT=7656 \
iex -S mix
```

Get the node_spec from shell 1
```elixir
:partisan.node_spec()
```

Copy the result on terminal #1 and make the following call in in terminals #2 and #3 by pasting the value as `arg`.

```elixir
:partisan_peer_service.join(arg)
```