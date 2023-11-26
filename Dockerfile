FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /App
EXPOSE 5000

# Copy todo
COPY . ./
# Restore paquetes
RUN dotnet restore
# Build and publish a release
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /App
COPY --from=build-env /App/out .
ENTRYPOINT ["dotnet", "BlazorApp.dll"]

# construir 
# local
# docker build -t blazorapp  .

# desde github
# docker build -t blazorapp  https://github.com/electronicasfederico/BlazorApp.git

# run 
# docker run -p 8080:5000 blazorapp 