# percentage %1 %2 instead of param https://discuss.elastic.co/t/winlogbeat-8-5-and-windows-11-22h2/318676/6
https://github.com/Graylog2/collector-sidecar/issues/449


# regedit service
HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\winlogbeat\ImagePath
"C:\Program Files\Elastic\Beats\8.5.2\winlogbeat\winlogbeat.exe" --environment=windows_service -c "C:\ProgramData\Elastic\Beats\winlogbeat\winlogbeat.yml" --path.home "C:\Program Files\Elastic\Beats\8.5.2\winlogbeat" --path.data "C:\ProgramData\Elastic\Beats\winlogbeat\data" --path.logs "C:\ProgramData\Elastic\Beats\winlogbeat\logs" -E logging.files.redirect_stderr=true
