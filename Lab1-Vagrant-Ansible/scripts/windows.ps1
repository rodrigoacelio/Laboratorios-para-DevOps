New-LocalUser -Name "windowsuser" -Password (ConvertTo-SecureString "SuperSenha123!" -AsPlainText -Force) -FullName "Windows User" -AccountNeverExpires -PasswordNeverExpires
Add-LocalGroupMember -Group "Administrators" -Member "windowsuser"
