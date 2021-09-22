data "alicloud_zones" "default" {
  available_instance_type = "ecs.t6-c1m2.large"
  available_disk_category = "cloud_ssd"
}

resource "alicloud_vpc" "default" {
  vpc_name    = "${var.name}"
  cidr_block  = "${var.cidr}"
}

resource "alicloud_vswitch" "public" {
  vswitch_name      = "${var.name}_public_${count.index}"
  vpc_id            = "${alicloud_vpc.default.id}"
  cidr_block        = "${cidrsubnet(var.cidr, 8, count.index)}"
  zone_id           = "${lookup(data.alicloud_zones.default.zones[count.index], "id")}"
  count             = "${var.az_count}"
}

resource "alicloud_vswitch" "private" {
  vswitch_name      = "${var.name}_private_${count.index}"
  vpc_id            = "${alicloud_vpc.default.id}"
  cidr_block        = "${cidrsubnet(var.cidr, 8, count.index + 2)}"
  zone_id           = "${lookup(data.alicloud_zones.default.zones[count.index], "id")}"
  count             = "${var.az_count}"
}