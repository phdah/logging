terraform {
    required_providers {
        kind = {
            source = "tehcyx/kind"
                version = "0.0.16"
        }
        kubectl = {
            source  = "gavinbunney/kubectl"
                version = "1.14.0"
        }
    }
}

provider "kind" {}

resource "kind_cluster" "log" {
    name = "log"
        wait_for_ready = true
        node_image = "kindest/node:v1.26.0"
        kind_config {
            kind = "Cluster"
                api_version = "kind.x-k8s.io/v1alpha4"

            node {
                role = "control-plane"
            }

            node {
                role = "worker"
            }

        }
}

provider "kubectl" {
        host                    = "${kind_cluster.log.endpoint}"
        cluster_ca_certificate  = "${kind_cluster.log.cluster_ca_certificate}"
        client_certificate      = "${kind_cluster.log.client_certificate}"
        client_key              = "${kind_cluster.log.client_key}"
        load_config_file        = false
}

data "kubectl_file_documents" "namespace" {
    content = file("namespace.yml")
}

resource "kubectl_manifest" "namespace" {
    depends_on = [
      kind_cluster.log,
    ]
    count = length(data.kubectl_file_documents.namespace.documents)
    yaml_body = element(data.kubectl_file_documents.namespace.documents, count.index)
}

data "kubectl_file_documents" "pv" {
    content = file("persistanvolume.yml")
}

resource "kubectl_manifest" "pv" {
    depends_on = [
      kind_cluster.log,
    ]
    count = length(data.kubectl_file_documents.pv.documents)
    yaml_body = element(data.kubectl_file_documents.pv.documents, count.index)
}
