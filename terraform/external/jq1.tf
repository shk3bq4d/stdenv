
data "external" "jq1" {
	program = ["bash", "-c", "curl -s https://raw.githubusercontent.com/helm/charts/master/stable/nginx-ingress/Chart.yaml | yq r -j - | yq r -j - |jq '{mykey: .appVersion}' -"]
}


output "jq1" {
	value = data.external.jq1.result.mykey
}
