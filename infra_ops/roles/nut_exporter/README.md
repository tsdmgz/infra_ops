Role Name
=========

A containerized deployment of <https://github.com/DRuggeri/nut_exporter>

Requirements
------------

* Podman

Role Variables
--------------

* `nut_exporter_env_dict`: a dictionary containing NUT exporter configuration
  parameters. At the very least should contain `NUT_EXPORTER_USERNAME`,
  `NUT_EXPORTER_PASSWORD`, `NUT_EXPORTER_SERVER`

Dependencies
------------

* `tsdmgz.infra_ops.nut`: not exactly required but works best with
