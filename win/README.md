# How

run command below on Powershell which run with admin privileges

```batch
 schtasks /Create /TN wsl-host /TR "path\to\script\set-wsl-hosts.bat" /SC DAILY /RI 10
```