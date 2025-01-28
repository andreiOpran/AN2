param (
    [string]$fileName  # Parametru: numele fișierului fără extensie
)

# Verifică dacă s-a furnizat un nume de fișier
if (-not $fileName) {
    Write-Host "Utilizare: .\compile.ps1 numeExecutabil"
    exit 1
}

# Adaugă extensia .cpp
$cppFile = "$fileName.cpp"

# Verifică dacă fișierul există
if (-not (Test-Path $cppFile)) {
    Write-Host "Eroare: Fisierul $cppFile nu exista!"
    exit 1
}

# Creează folderul bin dacă nu există
New-Item -ItemType Directory -Force ../bin | Out-Null

# Compilează fișierul
$exePath = "../bin/$fileName.exe"
g++ -o $exePath $cppFile

# Verifică dacă compilarea a reușit
if ($?) {
    Write-Host "Compilat cu succes: $exePath"
} else {
    Write-Host "Eroare la compilare!"
}
