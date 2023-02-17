resource "yandex_container_registry" "dpl_registry" {
  name = "dpl-registry"
}

#СОЗДАЕТСЯ 2 РЕПЫ. НУЖНО ПОДУМАТЬ, КАК УМЕНЬШИТЬ ДО 2 В ДВУХ ВОРКСПЕЙСАХ.