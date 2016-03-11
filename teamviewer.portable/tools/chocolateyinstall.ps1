﻿$ErrorActionPreference = 'Stop';

$packageName= 'teamviewer.portable'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://download.teamviewer.com/download/version_11x/TeamViewer_Setup.exe'
$filefullpath  = "$toolsDir\TeamViewerPortable.exe"
$exename = split-path -leaf $filefullpath

$packageArgs = @{
  packageName   = $packageName
  filefullpath  = $filefullpath
  url           = $url
  url64bit      = $url
}

Get-ChocolateyWebFile @packageArgs

$AppPathKey = "Registry::HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\$exeName"
If (!(Test-Path $AppPathKey)) {New-Item "$AppPathKey" | Out-Null}
Set-ItemProperty -Path $AppPathKey -Name "(Default)" -Value "$env:chocolateyinstall\lib\$packagename\tools\$exeName"
Set-ItemProperty -Path $AppPathKey -Name "Path" -Value "$env:chocolateyinstall\lib\$packagename\tools\"

Write-Output "*************************************************************************************"
Write-Output "*  INSTRUCTIONS: To use TeamViewer WITHOUT INSTALLING it:                           *"
Write-Output "*  1. At the command prompt or in the start menu type 'TeamViewerPortable'          *"
Write-Output "*  2. On the VERY FIRST dialog :                                                    *"
Write-Output "*       'How Do you want to proceed' select 'Run Only (one time use)'               *"
Write-Output "*       'How Do you want to use TeamViewer' select 'Personal / Non-commerical use'  *"
Write-Output "*  3. Click 'Accept - finsh'                                                        *" 
Write-Output "*************************************************************************************"