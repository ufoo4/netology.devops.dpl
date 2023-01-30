## Позже удалю...
resource "yandex_kms_symmetric_key" "kms_key" {
  name              = "${var.TF_VAR_WORKSPACE_NAME}-symetric-key"
  description       = "symetric key"
  default_algorithm = "AES_128"
  rotation_period   = "8760h"
}
