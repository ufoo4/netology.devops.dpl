## Позже удалю...
resource "yandex_kms_symmetric_key" "kms-key" {
  name              = "symetric-key"
  description       = "symetric key"
  default_algorithm = "AES_128"
  rotation_period   = "8760h"
}
