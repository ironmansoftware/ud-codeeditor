$IndexJs = Get-ChildItem "$PSScriptRoot\index.*.bundle.js"
$JsFiles = Get-ChildItem "$PSScriptRoot\*.js"
$Maps = Get-ChildItem "$PSScriptRoot\*.map"
$Pngs = Get-ChildItem "$PSScriptRoot\*.png"

$Script:MonacoAssetId = [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset($IndexJs.FullName)

foreach($item in $JsFiles)
{
    [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset($item.FullName) | Out-Null
}

foreach($item in $Maps)
{
    [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset($item.FullName) | Out-Null
}

$Pngs = Get-ChildItem "$PSScriptRoot\*.png"
foreach($item in $Pngs)
{
    [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset($item.FullName) | Out-Null
}


function script:New-UDCodeEditor {
    <#
    .SYNOPSIS
    Creates a new Monaco code editor control.
    
    .DESCRIPTION
    Creates a new Monaco code editor control.
    
    .PARAMETER Id
    The ID of this editor
    
    .PARAMETER Language
    The language to use for syntax highlighting.
    
    .PARAMETER Height
    The height of the editor.
    
    .PARAMETER Width
    The width of the editor.
    
    .PARAMETER HideCodeLens
    Hides code lens within th editor.
    
    .PARAMETER DisableCodeFolding
    Disables code folding.
    
    .PARAMETER FormatOnPaste
    Formats on paste.
    
    .PARAMETER GlyphMargin
    Seconds the size of the glyph margin
    
    .PARAMETER DisableLineNumbers
    Disables line numbers
    
    .PARAMETER DisableLinks
    Disables automatically highlighting links.
    
    .PARAMETER DisableBracketMatching
    Disables bracket matching. 
    
    .PARAMETER MouseWheelScrollSensitivity
    Sets the mouse wheel scroll sensitivity.
    
    .PARAMETER MouseWheelZoom
    Enables Ctrl+Scroll zooming. 
    
    .PARAMETER ReadOnly
    Sets the editor to readonly.
    
    .PARAMETER RenderControlCharacters
    Enables rendering of control characters.
    
    .PARAMETER ShowFoldingControls
    Controls how to show the folding controls. 
    
    .PARAMETER SmoothScrolling
    Enables smooth scrolling.
    
    .PARAMETER Theme
    Selects the theme. The default is the 'vs' theme. 
    
    .PARAMETER Code
    The code to show in the editor. 
    
    .EXAMPLE
    New-UDCodeEditor -Code 'Get-Process' -Theme 'vs-dark' -Language 'powershell' -Readonly 

    Creates a readonly code editor with PowerShell script. 
    #>
    
    param(
        [Parameter()]
        [string]$Id = (New-Guid).ToString(),
        [Parameter()]
        [ValidateSet('apex', 'azcli', 'bat', 'clojure', 'coffee', 'cpp', 'csharp', 'csp', 'css', 'dockerfile', 'fsharp', 'go', 'handlebars', 'html', 'ini', 'java', 'javascript', 'json', 'less', 'lua', 'markdown', 'msdax', 'mysql', 'objective', 'perl', 'pgsql', 'php', 'postiats', 'powerquery', 'powershell', 'pug', 'python', 'r', 'razor', 'redis', 'redshift', 'ruby', 'rust', 'sb', 'scheme', 'scss', 'shell', 'solidity', 'sql', 'st', 'swift', 'typescript', 'vb', 'xml', 'yaml')]
        [string]$Language,
        [Parameter()]
        [string]$Height,
        [Parameter()]
        [string]$Width,
        [Parameter()]
        [Switch]$HideCodeLens,
        [Parameter()]
        [Switch]$DisableCodeFolding,
        [Parameter()]
        [Switch]$FormatOnPaste,
        [Parameter()]
        [Switch]$GlyphMargin,
        [Parameter()]
        [Switch]$DisableLineNumbers,
        [Parameter()]
        [Switch]$DisableLinks,
        [Parameter()]
        [Switch]$DisableBracketMatching,
        [Parameter()]
        [int]$MouseWheelScrollSensitivity = 1,
        [Parameter()]
        [Switch]$MouseWheelZoom,
        [Parameter()]
        [Switch]$ReadOnly,
        [Parameter()]
        [Switch]$RenderControlCharacters,
        [Parameter()]
        [ValidateSet("always", "mouseover")]
        [string]$ShowFoldingControls = "mouseover",
        [Parameter()]
        [Switch]$SmoothScrolling,
        [Parameter()]
        [ValidateSet("vs", "vs-dark", "hc-black")]
        [string]$Theme = 'vs',
        [Parameter()]
        [string]$Code,
        [Parameter()]
        [string]$Original,
        [Parameter()]
        [Switch]$Autosize
    )

    End {

        # if ($Endpoint -is [scriptblock]) {
        #     $Endpoint = New-UDEndpoint -Endpoint $Endpoint -Id $Id
        # }
        # elseif ($Endpoint -isnot [UniversalDashboard.Models.Endpoint]) {
        #     throw "Endpoint must be a script block or UDEndpoint"
        # }

        @{
            assetId = $MonacoAssetId 
            isPlugin = $true 
            type = "ud-monaco"
            id = $Id

            height = $Height
            width = $Width
            language = $Language 
            codeLens = -not $HideCodeLens.IsPresent
            folding = -not $DisableCodeFolding.IsPresent
            formatOnPaste = $FormatOnPaste.IsPresent
            glyphMargin = $GlyphMargin.IsPresent
            lineNumbers = if ($DisableLineNumbers.IsPresent) { "off" } else { "on" }
            links = -not $DisableLinks.IsPresent
            matchBrackets = -not $DisableBracketMatching.IsPresent
            mouseWheelScrollSensitivity = $MouseWheelScrollSensitivity
            mouseWheelZoom = $MouseWheelZoom.IsPresent
            readOnly = $ReadOnly.IsPresent
            renderControlCharacters = $RenderControlCharacters.IsPresent
            showFoldingControls = $ShowFoldingControls
            smoothScrolling = $SmoothScrolling.IsPresent
            theme = $Theme
            code = $Code
            original = $Original
            autosize = $Autosize.IsPresent
        }
    }
}