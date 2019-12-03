@{
    Web = @{
        Static = @{
            Defaults = @(
                'index.html',
                'default.html'
            )
            Cache = @{
                Enable = $true
                MaxAge = 15
                Include = @(
                    '*.jpg'
                )
            }
        }
        ErrorPages = @{
            ShowExceptions = $true
            # StrictContentTyping = $true
            Default = 'application/html'
        }
    }
    Server = @{
        FileMonitor = @{
            Enable = $false
            Include = @("*.pode", "*.ps1", ".css", ".js")
        }
    }
}