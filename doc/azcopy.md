RUN wget -O azcopyv10.tar https://aka.ms/downloadazcopy-v10-linux && \
    tar -xf azcopyv10.tar && \
    mkdir /app && \
    mv azcopy_linux_amd64_*/azcopy /app/azcopy && \
    rm -rf azcopy* && \

AzCopy 10.14.1
Project URL: github.com/Azure/azure-storage-azcopy

AzCopy is a command line tool that moves data into and out of Azure Storage.
To report issues or to learn more about the tool, go to github.com/Azure/azure-storage-azcopy

The general format of the commands is: 'azcopy [command] [arguments] --[flag-name]=[flag-value]'.

Usage:
  azcopy [command]

Available Commands:
  bench       Performs a performance benchmark
  completion  Generate the autocompletion script for the specified shell
  copy        Copies source data to a destination location
  doc         Generates documentation for the tool in Markdown format
  env         Shows the environment variables that you can use to configure the behavior of AzCopy.
  help        Help about any command
  jobs        Sub-commands related to managing jobs
  list        List the entities in a given resource
  load        Sub-commands related to transferring data in specific formats
  login       Log in to Azure Active Directory (AD) to access Azure Storage resources.
  logout      Log out to terminate access to Azure Storage resources.
  make        Create a container or file share.
  remove      Delete blobs or files from an Azure storage account
  sync        Replicate source to the destination location

Flags:
      --cap-mbps float                      Caps the transfer rate, in megabits per second. Moment-by-moment throughput might vary slightly from the cap. If this option is set to zero, or it is omitted, the throughput isn't capped.
  -h, --help                                help for azcopy
      --output-type string                  Format of the command's output. The choices include: text, json. The default value is 'text'. (default "text")
      --trusted-microsoft-suffixes string   Specifies additional domain suffixes where Azure Active Directory login tokens may be sent.  The default is '*.core.windows.net;*.core.chinacloudapi.cn;*.core.cloudapi.de;*.core.usgovcloudapi.net;*.storage.azure.net'. Any listed here are added to the default. For security, you should only put Microsoft Azure domains here. Separate multiple entries with semi-colons.
  -v, --version                             version for azcopy

Use "azcopy [command] --help" for more information about a command.
