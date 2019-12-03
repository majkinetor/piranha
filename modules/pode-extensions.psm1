function Write-PodeLayoutResponse {
    param(
        # Path to the partial views that make up page layout
        [string] $Path,

        # Data to be passed to entire layout (the same data for each partial view)
        [HashTable] $Data = @{},

        # Array of content objects to be used along with views
        [object[]] $Content,
        
        [int] $StatusCode = 202,
        [switch] $FlashMessages,
        
        # Path to layout to be used, by default 'default'
        [string] $LayoutPath = 'default'
    )

    $Data.pagename = $Path
    $Data._Content = $Content
    Write-PodeViewResponse -Path "layouts/$LayoutPath" -Data $Data -FlashMessages:$FlashMessages -StatusCode $StatusCode
}

function vars( [HashTable]$v ) {
    if (!$Env:VARS) {return}
    else { $v; exit }
}

function Get-HtmlInterface([string] $Function ) {
    $res = ''
    $f = gcm $Function
    $skipParams = 'Verbose', 'Debug', 'ErrorAction', 'WarningAction', 'InformationAction', 'InformationVariable', 'ErrorVariable', 'WarningVariable', 'OutVariable', 'OutBuffer', 'PipelineVariable'
    foreach ($param in $f.Parameters.GetEnumerator()) {
        $name = $param.Key
        if ($name -in $skipParams) {continue}

        $r = "<div class='parameter' id='$name'>"

        $title = $name -creplace '(?<=[a-z])[A-Z]', ' $0'
        $r += "<label for='$name'><span>$title</span>"

        $param = $param.Value
        $type = $param.ParameterType
        $hm = $param.Attributes.HelpMessage
        $validValues = $param.Attributes.ValidValues
        if ($hm -eq 'x') {continue}
        switch ($type.Name) {
            {'String[]','String','Integer','Uint32' -contains $_} { 
                if ($validValues) {
                    $r +="<select name='$name'>"
                    $r += foreach ($v in $validValues) { "<option>$v</option>" }
                    $r += "</select>"
                } else {
                    $r += "<input name='$name' id='$name' type='text'"
                    $r += if ($hm) { " placeholder='$hm'" }
                    $r += '>'
                }
            }
            'SwitchParameter' {
                $r += "<input name='$name' id='$name' type='checkbox' value='$true'>"
            }
            Default {}
        }

        $r += "</label></div>"
        $res += $r
    }
    $res
}

# Author: Miodrag Milic <miodrag.milic@gmail.com>
# Last Change: 14-Mar-2015.

#requires -version 2.0

<#
.SYNOPSIS
    Set enviornment variable
.EXAMPLE
    Set-EnvironmentVarable TMP "c:\Windows\TEMP" -Machine -Verbose

    Adds environment varible to the current console and registers it
    at the 'machine' level
.EXAMPLE
    Set-EnvironmentVarable PATH ";c:\Windows\TEMP" -Verbose -Append

    Appends value to the PATH variable
#>
function Set-EnvironmentVariable()
{
    [CmdletBinding(DefaultParameterSetName='Manual')]
    param(
        # Name of the environment variable, it doesn't have to exist
        [string]$Name,
        # Value of the environment variable
        [string]$Value,
        # Set to create environment variable for the machine instead for the current user
        [switch]$Machine,
        # Set to append Value to the existing value of the environment variable
        [switch]$Append,
        # Set to prepend a Value to the existing one of the environment variable
        [switch]$Prepend
    )
    $type = "User"
    if ($Machine) { $type = "Machine" }
    $old = [System.Environment]::GetEnvironmentVariable($Name, $type)

    if ($Append)  {$Value = "${old}${Value}" }
    if ($Prepend) {$Value = "${Value}${old}" }

    Set-Item Env:$name $value
    [System.Environment]::SetEnvironmentVariable($Name, $Value, $type)
    if ($old -ne $null) {
        Write-Verbose "$type environment variable changed."
        Write-Verbose "Previous value: $old"
    }
    else {
        Write-Verbose "$type environment variable created."
    }
}

Set-Alias env  Set-EnvironmentVariable
