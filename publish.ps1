# Define variables
$apiKey = "oy2gutd4cobrob52vbqae6agekadle4udmwbqj44xemgde"
$publishDirBase = "./packages/"
$packageDir = "../package/"

# Get all .csproj files in the directory
$projectFiles = Get-ChildItem . -Recurse -Filter "*.csproj"

# Loop over all .csproj files
foreach ($projectFile in $projectFiles) {
    # Publish
    $publishDir = $publishDirBase + ($projectFile.Name -replace ".csproj", "")
    dotnet publish $projectFile.FullName -c Release -o $publishDir

    # Pack
    dotnet pack $projectFile.FullName --output $publishDir

    # Push
    $packageFile = $publishDir + "/" + ($projectFile.Name -replace ".csproj", ".1.0.0.nupkg")
    nuget push $packageFile -Source https://api.nuget.org/v3/index.json -ApiKey $apiKey
}