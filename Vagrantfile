# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "gusztavvargadr/windows-10"
  config.vm.provision "shell", inline: <<-SHELL
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    choco install pwsh -y
    Set-PSRepository PSGallery -InstallationPolicy Trusted
    Install-Module PSFramework
  SHELL
end
