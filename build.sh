#!/bin/bash

set -eu

gir_version="2.0.0"
json_ds_version="1.4.1"

build_dir=$PWD/build
out_dir=${build_dir}/out
install -d "${out_dir}"

build_gir() {
  local version=$1

  wget --no-verbose -O "${build_dir}/gir.zip" \
      "https://github.com/grafana/grafana-image-renderer/releases/download/v${version}/plugin-linux-x64-glibc.zip"

  unzip -o -d "${out_dir}" "${build_dir}/gir.zip"

  if [ ! -d "${out_dir}/grafana-image-renderer" ]; then
    mv -v "${out_dir}/plugin-linux-x64-glibc" \
       "${out_dir}/grafana-image-renderer"
  fi
}

build_json_datasource() {
  local version=$1

  wget --no-verbose -O"${build_dir}/sjd.zip" \
      "https://grafana.com/api/plugins/grafana-simple-json-datasource/versions/${version}/download"

  unzip -o -d "${out_dir}" "${build_dir}/sjd.zip"

  if [ ! -d "${out_dir}/grafana-simple-json-datasource" ]; then
    mv -v ${out_dir}/grafana-simple-json-datasource-* \
       "${out_dir}/grafana-simple-json-datasource"
  fi
}

build_gir ${gir_version}
build_json_datasource ${json_ds_version}
