## Позже удалю...
resource "yandex_kms_symmetric_key" "kms-key" {
  name              = "${var.TF_VAR_WORKSPACE_NAME}-symetric-key"
  description       = "symetric key for workspace ${var.TF_VAR_WORKSPACE_NAME}"
  default_algorithm = "AES_128"
  rotation_period   = "8760h"
}
