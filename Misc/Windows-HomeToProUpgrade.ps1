write-host "*** Starting script"
#This will do the key change offline

write-host "*** Stopping internet"
#Stop internet
route delete 0.0.0.0
#Wait 
Start-Sleep -Seconds 1

write-host "*** Changing key"
#Set to generic key - DO NOT CHANGE THIS KEY
#one of these lines will error - that's ok
start-process -filepath 'c:\windows\sysnative\changepk.exe' -argumentlist '/ProductKey VK7JG-NPHTM-C97JM-9MPGT-3V66T'
start-process -filepath 'changepk.exe' -argumentlist '/ProductKey VK7JG-NPHTM-C97JM-9MPGT-3V66T'
Start-Sleep -Seconds 30

write-host "*** Reconnecting network"

#Start internet again, assuming on DHCP!
ipconfig /renew 

write-host "*** Rebooting"

restart-computer -force

write-host "*** You should now be able to change to the correct key"
write-host "*** Ending script"



#END