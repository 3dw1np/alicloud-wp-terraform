data "alicloud_zones" "default" {
  available_instance_type = "${var.ecs_type}"
  available_disk_category = "cloud_ssd"
}

resource "alicloud_instance" "web" {
  instance_name              = "${var.name}_web_srv_${count.index}"
  instance_type              = "${var.ecs_type}"
  system_disk_category       = "cloud_ssd"
  system_disk_size           = 30
  image_id                   = "${var.ecs_image_name}"
  count                      = "${var.vm_count}"

  vswitch_id                 = "${element(alicloud_vswitch.public.*.id, count.index)}"
  internet_max_bandwidth_out = 0 // Not allocate public IP for VPC instance

  security_groups            = ["${alicloud_security_group.web.id}", "${alicloud_security_group.ssh.id}"]
  # user_data                  = "${element(data.template_file.user_data.*.rendered, count.index)}"
  password                   = "${var.ssh_password}"

  depends_on                 = [alicloud_db_instance.default, alicloud_db_account.account]
}

resource "alicloud_db_instance" "default" {
    instance_name         = "${var.name}-db-srv"
    engine                = "MySQL"
    engine_version        = "8.0"
    instance_type         = "${var.rds_type}"
    instance_storage      = "10"

    vswitch_id            = "${element(alicloud_vswitch.private.*.id, 0)}"
    security_ips          = ["192.168.1.0/24", "192.168.2.0/24"]
}

resource "alicloud_db_account" "account" {
  db_instance_id   = "${alicloud_db_instance.default.id}"
  account_name     = "wp_agency"
  account_password = random_password.password.result
}