# msbuild-docker

an image with msbuild tools

Contains:

* .NET Framework 4.7.1
* Visual C++ Build Tools (& associated C++ sdks) (see [Visual Studio Build Tools 2017 component directory](https://docs.microsoft.com/en-us/visualstudio/install/workload-component-id-vs-build-tools))
    ```bash
    vs_buildtools.exe \
    --quiet --addProductLang en-US --includeOptional --nocache --wait --installPath C:\BuildTools \
    --add Microsoft.VisualStudio.Workload.VCTools \
    --remove Microsoft.VisualStudio.Component.Windows10SDK.10240 \
    --remove Microsoft.VisualStudio.Component.Windows10SDK.10586 \
    --remove Microsoft.VisualStudio.Component.Windows10SDK.14393 \
    
    ```
* NuGet v4.5.1

Run the image with:

`docker run -it -v ${PWD}:c:\work --workdir c:\work nullreference/msbuild`
