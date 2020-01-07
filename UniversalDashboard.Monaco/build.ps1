$BuildFolder = $PSScriptRoot

$powerShellGet = Import-Module PowerShellGet  -PassThru -ErrorAction Ignore
if ($powerShellGet.Version -lt ([Version]'1.6.0')) {
	Install-Module PowerShellGet -Scope CurrentUser -Force -AllowClobber
	Import-Module PowerShellGet -Force
}

Set-Location $BuildFolder

$OutputPath = "$BuildFolder\output\UniversalDashboard.CodeEditor"

Remove-Item -Path $OutputPath -Force -ErrorAction SilentlyContinue -Recurse
Remove-Item -Path "$BuildFolder\public" -Force -ErrorAction SilentlyContinue -Recurse

New-Item -Path $OutputPath -ItemType Directory

& cyclonedx-bom -o monaco.bom.xml
npm install
npm run build

Copy-Item $BuildFolder\public\*.* $OutputPath
Copy-Item $BuildFolder\UniversalDashboard.CodeEditor.psm1 $OutputPath

$Version = "1.0.2"

$manifestParameters = @{
	Path = "$OutputPath\UniversalDashboard.CodeEditor.psd1"
	Author = "Adam Driscoll"
	CompanyName = "Ironman Software, LLC"
	Copyright = "2019 Ironman Software, LLC"
	RootModule = "UniversalDashboard.CodeEditor.psm1"
	Description = "Code editor control for Universal Dashboard. This controls requires a Universal Dashboard Enterprise license."
	ModuleVersion = $version
	Tags = @("universaldashboard", "monaco", 'code', 'ud-control')
	ReleaseNotes = "Added support for loading license from environment variable."
	FunctionsToExport = @(
		"New-UDCodeEditor"
	)
	RequiredModules = @()
	LicenseUri = "https://poshtools.com/universal-dashboard-license/"
	ProjectUri = "https://github.com/ironmansoftware/ud-codeeditor"
	IconUri = 'https://raw.githubusercontent.com/ironmansoftware/universal-dashboard/master/images/logo.png'
}

New-ModuleManifest @manifestParameters

if ($prerelease -ne $null) {
	Update-ModuleManifest -Path "$OutputPath\UniversalDashboard.CodeEditor.psd1" -Prerelease $prerelease
}