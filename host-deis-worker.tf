resource "aws_autoscaling_group" "deis-workers" {
  name = "Deis Workers"

  # Network
  availability_zones = ["${aws_subnet.subnet.*.availability_zone}"]
  vpc_zone_identifier = ["${aws_subnet.subnet.*.id}"]

  # Cluster Size
  max_size = 12
  min_size = 3
  desired_capacity = "${lookup(var.counts, "workers")}"

  # General Configuration
  force_delete = true
  launch_configuration = "${aws_launch_configuration.deis-worker.id}"

}

resource "aws_launch_configuration" "deis-worker" {
    name = "deis-worker"

    # General Config
    image_id = "${lookup(var.amis, "coreos")}"
    instance_type = "${lookup(var.instance_types, "core")}"
    user_data = "${replace(replace(file("conf/deis-worker/user-data"), "{{etcd_lb}}", "${aws_elb.etcd.dns_name}"), "{{deis_version}}", "${var.deis_version}")}"
    key_name = "deis"

    # Networking
    security_groups = ["${aws_security_group.deis-private.id}"]
    associate_public_ip_address = true

    # Storage
    root_block_device {
      volume_size = 50
      volume_type = "gp2"
    }

    ebs_block_device {
      device_name = "/dev/xvdf"
      volume_size = 100
      volume_type = "gp2"
    }

}
