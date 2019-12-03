vars @{
    title = 'AD create'
}

form -Action /adcreate -method post -enctype multipart/form-data -Content {
    label 'Full name' -Attributes @{ for="fullname"}
    input -id fullname -name fullname -type text -Attributes @{ Placeholder="Write full name using Unicode" } 

    label 'Company name' -Attributes @{ for="companyname"}
    input -id companyname -name companyname -type text -Attributes @{ Placeholder="Set for external participants" }
    # Get-ADGroup -Filter { Name -like 'c-*'} | ? Name -ne 'c-NIL' | % Name | % { $_.Substring(2) }

    label 'Department' -Attributes @{ for="department"}
    selecttag -id department -name department {
        option "Development"
        option "Infrastructure"
    }
    # Get-ADGroup -Filter { Name -like 'c-*'} | ? Name -ne 'c-NIL' | % Name | % { $_.Substring(2) }

    label 'E-Mail' -Attributes @{ for="email"}
    input -id email -name email -type email -Attributes @{ Placeholder="foo@bar.com" }

    label -Attributes @{ for="enableVPN"} -Content {
        input -id enableVPN -name enableVPN -type checkbox -value $true 
        ' Enable VPN' 
    }

    input -name submit -type submit -value submit
    a Docs -href "https://redmine.nil.rs/projects/serverska-infrastruktura/wiki/AD" -Attributes @{style="padding-left:1em"}

}
