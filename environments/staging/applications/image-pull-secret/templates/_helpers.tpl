{{/*
  Expand the name of the chart.
*/}}
{{- define "image-pull-secret.name" -}}
  {{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
  Create chart name and version as used by the chart label.
*/}}
{{- define "image-pull-secret.chart" -}}
  {{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
  Generate the .dockerconfigjson file unencoded.
*/}}
{{- define "image-pull-secret.render" }}
  {{- print "{\"auths\":{" }}
  {{- range $index, $item := .Values.imageCredentials }}
    {{- if $index }}
      {{- print "," }}
    {{- end }}
    {{- printf "\"%s\":{\"auth\":\"%s\"}" (default "https://index.docker.io/v1/" $item.registry) (printf "%s" $item.auth) }}
  {{- end }}
  {{- print "}}" }}
{{- end }}

{{/*
  Generate the base64-encoded .dockerconfigjson.
  See https://github.com/helm/helm/issues/3691#issuecomment-386113346
*/}}
