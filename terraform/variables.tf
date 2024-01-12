variable "algorithm" {
  description = "The cryptographic algorithm to use."
  type        = string
}

variable "ecdsa_curve" {
  description = "The elliptic curve for ECDSA algorithm."
  type        = string
}

variable "kubeconfig" {
  description = "path to kubeconfig"
  type        = string
}

variable "GOOGLE_PROJECT" {
  type        = string
  default     = "GKE CLUSTER LE"
  description = "GCP project name"
}

variable "GOOGLE_REGION" {
  type        = string
  default     = "us-central1-c"
  description = "GCP region to use"
}

variable "GITHUB_OWNER" {
  type        = string
  description = "GitHub owner repository to use"
}

variable "GITHUB_TOKEN" {
  type        = string
  description = "GitHub personal access token"
}

variable "FLUX_GITHUB_REPO" {
  type        = string
  default     = "flux-gitops"
  description = "Flux GitOps repository"
}

