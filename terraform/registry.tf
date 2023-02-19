resource "yandex_container_registry" "dpl_registry" {
  name = "dpl-registry"
}

#СОЗДАЕТСЯ 2 РЕПЫ. НУЖНО ПОДУМАТЬ, КАК УМЕНЬШИТЬ ДО 1 В ДВУХ ВОРКСПЕЙСАХ.