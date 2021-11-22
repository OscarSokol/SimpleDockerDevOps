#Get new base images for our app
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /app
EXPOSE 80

#Copy csproj file and restore packges
COPY *.csproj ./
RUN dotnet restore

# Copy the project files and build our release:
# . means (root directory) that we copy evrythings to WORDIR
COPY . ./
# -c to check if this is release version 
# -o output folder 
RUN dotnet publish -c Release -o /app/publish

#build run time image from base(build-env) to new image
FROM mcr.microsoft.com/dotnet/sdk:6.0  
WORKDIR /app
COPY --from=build-env /app/publish . 
ENTRYPOINT [ "dotnet" , "DockerSimple.dll" ]

#dotnet build
#dotnet run
#git init
#git status - include in what will be committed
#git add . - we want to track “everything”, (except those files ignored!)

