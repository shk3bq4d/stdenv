github.com/user.key # ssh key

Issue in the same repository	KEYWORD #ISSUE-NUMBER	Closes #10
Issue in a different repository	KEYWORD OWNER/REPOSITORY#ISSUE-NUMBER	Fixes octo-org/octo-repo#100
Multiple issues	Use full syntax for each issue	Resolves #10, resolves #123, resolves octo-org/octo-repo#100


# skip CI commit message git
```yaml
[skip ci]
[ci skip]
[no ci]
[skip actions]
[actions skip]
Alternatively, you can end the commit message with two empty lines followed by either:

skip-checks:true
skip-checks: true
```

# GH github CLI
https://cli.github.com/manual/
```sh
gh --repo https://github.com/cli/cli release list --limit 50
gh --repo https://github.com/cli/cli release view v2.28.0
gh --repo https://github.com/cli/cli release download -p 'gh_*_amd64.tar.gz'
gh --repo https://github.com/kubernetes/kubernetes release list --limit 50
gh --repo https://github.com/wso2/product-apim release list | cat # piping allows to have absolute date instead of relative "one month ago"
gh --repo https://github.com/wso2/product-apim release list | grep -v Pre-release
gh --repo https://github.com/wso2/product-apim search commits
gh --repo https://github.com/ansible/ansible release list --limit 40
gh --repo https://github.com/ansible/ansible release list --limit 40 | grep v2.13
gh --repo https://github.com/ansible-collections/ansible.posix.git        release list --limit 10
gh --repo https://github.com/ansible-collections/ansible.netcommon.git    release list --limit 10
gh --repo https://github.com/ansible-collections/community.mysql.git      release list --limit 10
gh --repo https://github.com/ansible-collections/ansible.windows.git      release list --limit 10
gh --repo https://github.com/ansible-collections/kubernetes.core.git      release list --limit 10
gh --repo https://github.com/ansible-collections/azure.git                release list --limit 10
gh --repo https://github.com/ansible-collections/community.postgresql.git release list --limit 10
gh --repo https://github.com/ansible-collections/community.zabbix.git     release list --limit 10
gh --repo https://github.com/ansible-collections/community.general.git    release list --limit 10
gh --repo https://github.com/ansible-collections/community.docker.git     release list --limit 10
gh --repo https://github.com/ansible-collections/community.crypto.git     release list --limit 10
gh --repo https://github.com/netbox-community/ansible-modules             release list --limit 10
```
