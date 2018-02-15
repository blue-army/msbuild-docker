# msbuild-docker

an image with msbuild tools

Contains:

* .NET Framework 4.7.1
* Visual C++ Build Tools (& associated C++ sdk)
* NuGet v4.5.1

Run the image with:

`docker run -it -v ${PWD}:c:\work --workdir c:\work buildtools:latest`
