describe 'mssql-demo::webserver'  {
    It "Should have the Web Server Role" { 
      (Get-WindowsFeature -name Web-Server).Installed | Should Be $true # Probably not the right service name but it's okay for now.
    }

    It "Should have World Wide Web Publishing Service running" {
      (Get-Service -name 'W3SVC').status | Should Be 'Running'
      (Get-WmiObject win32_service | Where {$_.Name -eq "W3SVC"}).StartMode | Should Be "Auto"
    }

    It "Should have a default website" {
      Get-Website -Name "Default Web Site" | Should be $true
      (Get-Website -Name "Default Web Site").State | Should be "Started"
    }
    # We need to figure out a way to enssure that the app pool is bound to the site, etc, but this is a start
    It "Should have a default app pool" {
     Get-WebAppPoolState -Name "DefaultAppPool" | Should be $true
     (Get-WebAppPoolState -Name "DefaultAppPool").value | Should be "Started"
    }
}
