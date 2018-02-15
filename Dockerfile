# FROM microsoft/windowsservercore:10.0.14393.2007
FROM microsoft/dotnet-framework-build:4.7.1

RUN mkdir -p c:/installer
COPY vs_buildtools.exe c:/installer

SHELL ["powershell.exe", "-ExecutionPolicy", "Bypass", "-Command"]

# Nuget (Update to latest)
RUN $ErrorActionPreference = 'Stop'; \
	$ProgressPreference = 'SilentlyContinue'; \
	$VerbosePreference = 'Continue'; \
	Invoke-WebRequest -Uri "https://dist.nuget.org/win-x86-commandline/latest/nuget.exe" -OutFile 'C:\Program Files\NuGet\nuget.exe';

# RUN $ErrorActionPreference = 'Stop'; \
# 	$ProgressPreference = 'SilentlyContinue'; \
# 	$VerbosePreference = 'Continue'; \
# 	$p = Start-Process -Wait -PassThru -FilePath c:\installer\vs_buildtools.exe -ArgumentList \
# 	'--quiet --addProductLang en-US --includeOptional --nocache --wait --installPath C:\BuildTools \
# 	--add Microsoft.VisualStudio.Workload.MSBuildTools \
# 	'; \
# 	if ($ret = $p.ExitCode) { throw ('Install failed with exit code 0x{0:x}' -f $ret) };

# RUN $ErrorActionPreference = 'Stop'; \
# 	$ProgressPreference = 'SilentlyContinue'; \
# 	$VerbosePreference = 'Continue'; \
# 	$p = Start-Process -Wait -PassThru -FilePath c:\installer\vs_buildtools.exe -ArgumentList \
# 	'--quiet --addProductLang en-US --includeOptional --nocache --wait --installPath C:\BuildTools \
# 	--add Microsoft.VisualStudio.Workload.NetCoreBuildTools \
# 	'; \
# 	if ($ret = $p.ExitCode) { throw ('Install failed with exit code 0x{0:x}' -f $ret) };

# VC++ Tools
RUN $ErrorActionPreference = 'Stop'; \
	$ProgressPreference = 'SilentlyContinue'; \
	$VerbosePreference = 'Continue'; \
	$p = Start-Process -Wait -PassThru -FilePath c:\installer\vs_buildtools.exe -ArgumentList \
	'--quiet --addProductLang en-US --includeOptional --nocache --wait --installPath C:\BuildTools \
	--add Microsoft.VisualStudio.Workload.VCTools \
	--remove Microsoft.VisualStudio.Component.Windows10SDK.10240 \
    --remove Microsoft.VisualStudio.Component.Windows10SDK.10586 \
    --remove Microsoft.VisualStudio.Component.Windows10SDK.14393 \
	'; \
	if ($ret = $p.ExitCode) { throw ('Install failed with exit code 0x{0:x}' -f $ret) };

# RUN $ErrorActionPreference = 'Stop'; \
# 	$ProgressPreference = 'SilentlyContinue'; \
# 	$VerbosePreference = 'Continue'; \
# 	$p = Start-Process -Wait -PassThru -FilePath c:\installer\vs_buildtools.exe -ArgumentList \
# 	'--quiet --addProductLang en-US --includeRecommended --nocache --wait --installPath C:\BuildTools \
# 	--add Microsoft.VisualStudio.Workload.WebBuildTools \
# 	--add Microsoft.Net.Component.4.6.2.SDK \
# 	--add Microsoft.Net.Component.4.6.2.TargetingPack \
# 	--add Microsoft.Net.ComponentGroup.4.6.2.DeveloperTools \
# 	'; \
# 	if ($ret = $p.ExitCode) { throw ('Install failed with exit code 0x{0:x}' -f $ret) };

# Zip up logs
RUN Compress-Archive -Path (Get-Item env:TEMP).Value -DestinationPath c:\vs_logs

# Use shell form to start developer command prompt and any other commands specified
SHELL ["cmd.exe", "/s", "/c"]
ENTRYPOINT C:\BuildTools\Common7\Tools\VsDevCmd.bat &&

# Default to PowerShell console running within developer command prompt environment
CMD ["powershell.exe", "-nologo"]