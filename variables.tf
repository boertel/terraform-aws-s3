variable "region" {
    default = "us-east-1"
}

variable "allowed_origins" {
    type = list(string)
    default = ["http://localhost:3000"]
}

variable "bucket" {
    type  = string
}

variable iam_user_name {
    type  = string
    default = ""
}

variable iam_policy_name {
    type  = string
    default = ""
}

variable pgp_key_path {
}
