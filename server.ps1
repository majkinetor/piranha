param( [int] $Port = 8086 )

Start-PodeServer -RootPath $PSScriptRoot {

    Add-PodeEndpoint -Address * -Port $Port -Protocol Http
    Set-PodeViewEngine -Type PSHTML -Extension PS1 -ScriptBlock { param($path, $data) [string](. $path $data) }
    Import-PodeModule -Path "./modules/pode-extensions.psm1"

    Add-PodeRoute -Method Get -Path '/' -ScriptBlock { param ($e)
        Write-PodeLayout home $e -Data @{title="Home"}
    }

    ls $PSScriptRoot\views\scripts\*.ps1 | % {
        $name = $_.BaseName
        Write-Host "Adding $name"
        Add-PodeRoute -Method Get -Path "/$name" -ScriptBlock { param ($e)
            Write-PodeLayout scripts/$name
        }
    }

    # Add-PodeRoute -Method Get -Path '/test' -ScriptBlock { param ($e)
    #     Write-PodeLayout scripts/test $e -Data @{ title="Test"}
    # }
}