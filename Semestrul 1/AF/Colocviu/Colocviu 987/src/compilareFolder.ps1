New-Item -ItemType Directory -Force ../bin
Get-ChildItem -Filter "*.cpp" | ForEach-Object {
    $exeName = "../bin/" + [System.IO.Path]::GetFileNameWithoutExtension($_.Name)
    g++ -o $exeName $_.Name
    Write-Output "Terminat de compilat: $exeName"
}

# permisiune rulare script
# Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
