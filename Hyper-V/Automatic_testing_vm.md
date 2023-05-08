# Quickly create Windows 10 VMs for testing
1. Install Hyper-v if it is not already installed. If you run into any powershell errors, make sure your hardware supports virtualization. Additionally, you may need to turn on virtualization in your BIOS.

```powershell
# From admin powershell
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
```
2. Reboot your computer
3. Download a Windows 10 ISO with the [Windows Media Creation Tool](https://www.microsoft.com/en-us/software-download/windows10) 
4. Open Hyper-V manager
5. Create a new Virtual Machine



