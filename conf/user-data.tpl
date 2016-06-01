#cloud-config
coreos:
  fleet:
    public-ip: $private_ipv4
    metadata: "${fleet_tags}"
    engine-reconcile-interval: 10
    etcd-request-timeout: 5.0
    agent-ttl: 120s

  update:
    reboot-strategy: best-effort
    group: stable

  etcd2:
    initial-cluster: core-1=http://core-1.brandfolder.host:2380,core-2=http://core-2.brandfolder.host:2380,core-3=http://core-3.brandfolder.host:2380,core-4=http://core-4.brandfolder.host:2380,core-5=http://core-5.brandfolder.host:2380
    listen-client-urls: "http://0.0.0.0:2379,http://0.0.0.0:4001"
    proxy: on

  units:
    ${join("\n    ", split("\n", units))}

    ${join("\n    ", split("\n", file("conf/shared/units.yml")))}

write_files:
  - path: /etc/deis-release
    content: |
      DEIS_RELEASE=v${file("conf/deis-version")}

  ${join("\n  ", split("\n", files))}

  ${join("\n  ", split("\n", file("conf/shared/files.yml")))}
