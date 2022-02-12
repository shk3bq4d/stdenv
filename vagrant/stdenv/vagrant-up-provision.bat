set PATH=c:\HashiCorp\Vagrant\bin;%PATH%
echo %CD%
c:\HashiCorp\Vagrant\bin\vagrant.exe box update
c:\HashiCorp\Vagrant\bin\vagrant.exe up --provision
pause
