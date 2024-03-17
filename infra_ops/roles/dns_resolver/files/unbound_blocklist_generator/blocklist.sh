#!/bin/bash -x

tmpdir=$(mktemp -d -t blockhostsXXXXXX)
list_sns=${tmpdir}/sns.txt
processed_acl_list=${tmpdir}/91-acl.conf
unbound_config=${unbound_config:=/etc/unbound/}
tag_list=${unbound_config:=/etc/unbound/}local.d/00-taglist.conf
cleanup=${no_cleanup:=true}

function download_file() {
    declare local _url=${1}
    curl --retry 3 --max-time 60 --connect-timeout 10 --location ${_url}
    if [[ $? -ne 0 ]]; then
        >&2 echo "Failed to download ${_url}. Aborting"
        exit 1;
    fi
}

function parse_type_1() {
    # Format:
    # example.com
    #
    :
}

function parse_type_2() {
    # Format:
    # 0.0.0.0 example.com
    awk '/^#.*/ !~ $0 {print $2}' ${1}
}

function tag_domain() {
    # add local-zone-tag and local-zone for given domain list
    :
}

function facebook_block_process() {
    # Facebook sinkhole
    ex ${1} <<<'
    /# Facebook
    1,.d
    /\n\n
    +1
    .,$d
    %p
    '|awk '
    # local-zone-tag: "example.com." "socialmedia"
    {print "local-zone-tag: " "\x22" $2 ".\x22 " "\x22socialmedia\x22"}
    # local-zone: "example.com." always_nxdomain
    {print "local-zone: " "\x22" $2 ".\x22 " "always_refuse"}
    '
}

download_file 'https://github.com/Sinfonietta/hostfiles/raw/master/social-hosts' > ${list_sns} &
wait

cat <<EOF > ${tag_list}
define-tag: "malware socialmedia"
EOF

facebook_block_process ${list_sns} >> ${processed_acl_list}

install -D ${processed_acl_list} ${unbound_config}/local.d/$(basename ${processed_acl_list})

unbound-control status && unbound-checkconf && unbound-control reload_keep_cache || echo "ERROR: Checks failed, did not reload"
if [ $cleanup = true ]; then
    rm -rf ${tmpdir}
fi
