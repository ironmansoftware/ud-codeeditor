# Universal Dashboard Code Editor

Code editor control for [Universal Dashboard](https://github.com/ironmansoftware/universal-dashboard) based on [Monaco](https://microsoft.github.io/monaco-editor/).

![](./images/image.png)

# Installation

```
Install-Module UniversalDashboard.CodeEditor
```

# Licensing

This component requires a [Universal Dashboard Enterprise license](https://ironmansoftware.com/powershell-universal-dashboard/). 

# Issues 

Please file issues on the [Universal Dashboard GitHub repository](https://github.com/ironmansoftware/universal-dashboard).

# Examples 

## Creating an editor

```
New-UDCodeEditor -Language 'powershell' -Height '100ch' -Width '100ch' -Code 'Start-Process'
```

## Readonly Editor

```
New-UDCodeEditor -Language 'powershell' -Height '100ch' -Width '100ch' -Theme vs-dark -Code "Get-Process" -ReadOnly
```

## Adding Content

```
New-UDCodeEditor -Id 'editor' -Language 'powershell' -Height '100ch' -Width '100ch' -Theme vs-dark -Code "Get-Process" -ReadOnly
New-UDButton -Text 'Add Text' -OnClick {
    Add-UDElement -ParentId 'editor' -Content {
        'Get-Process'
    }
}
```

## Getting Content

```
New-UDCodeEditor -Id 'editor' -Language 'powershell' -Height '100ch' -Width '100ch' -Theme vs-dark
New-UDButton -Text "Get Text" -OnClick {
    Show-UDToast -Message (Get-UDElement -Id 'editor').Attributes["code"]
}
```

## Setting Content

```
New-UDCodeEditor -Id 'editor' -Language 'powershell' -Height '100ch' -Width '100ch' -Theme vs-dark
 New-UDButton -Text "Set Text" -OnClick {
    Set-UDElement -Id 'editor' -Attributes @{
        code = 'Get-Service'
    }
}
```