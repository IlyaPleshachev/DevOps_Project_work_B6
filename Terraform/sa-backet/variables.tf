# Я.облако
variable "folder_id" {
    description = "Выбранный ID каталога"
    type = string
    default = "b1gjgig2i53rj4q0n61b"
}

variable "cloud_id" {
    description = "Выбранный ID обалка"
    type = string
    default = "b1garivv1r2su74hm7dm"
}

variable "token" {
    description = "Token авторизации"
    type = string
    default = "TOPiddqdidkfaSECRET"
}

variable "zone" {
    description = "Access zone - a"
    type = string
    default = "ru-central1-a"
}