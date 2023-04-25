# Publish to the PowerShell Gallery

# The code in this script is used to publish to the PSGallery.


#------------------------------------------------------------------------------------------------
# Prerequisites
#------------------------------------------------------------------------------------------------
<#

Go to the PowerShell Gallery [https://www.powershellgallery.com/](https://www.powershellgallery.com/).

Use the API Keys feature to generate a new API Key for your module.

Fill in the Key Name (name of the module would work well), use the default expire date.

Scope should be push, push new packages and package versions

For glob pattern just use an * (Asterisk). 

Take rest of defaults and click Create.

Important! Once created, make sure to copy down the API key as you can't go back and see it again.
Right now I'm storing keys in the note PowerShell Gallery Login and API Info.

Next, install the DotNet SDK.

winget install Microsoft.DotNet.SDK.7

Then you need to install the PowerShellGet module to your user scope.

Install-Module PowerShellGet -Scope CurrentUser

This will put a version in your Users\Documents\PowerShell folder. Then when you are ready
to import the module you need to specify the path to it in your user folder.

#>

#------------------------------------------------------------------------------------------------
# Module Manifest
#------------------------------------------------------------------------------------------------

# To publish you must have a module manifest (a PSD1 file). If you don't have one, you can use
# the `New-ModuleManifest` cmdlet.

New-ModuleManifest `
    -Path C:\Projects\yourproject\module.psd1 `
    -PassThru

#------------------------------------------------------------------------------------------------
# Manifest Elements
#------------------------------------------------------------------------------------------------

<#
These are the elements from the manifest file that must or should be included.

Script or Module name comes from the file name of the PSD1 file.

Version - Required. Format: Major.Minor.Incremental such as 1.12.4

Major represents a major or breaking change
Minor represents feature level changes, such as new cmdlets
Incremental represents non breaking changes, such as new parameters or updated samples/help

Author - Required
Description - Required
HelpInfoURI - Highly suggested, link to the GitHub (or other) location of the project
Tags - Suggested
#>

#------------------------------------------------------------------------------------------------
# Validate the manifest file
#------------------------------------------------------------------------------------------------

# Now you should validate your manifest by using `Test-ModuleManifest`

Test-ModuleManifest -Path ./ArcaneBooks.psd1

# If no errors show up you are good to this point. Other wise fix and test again.


#------------------------------------------------------------------------------------------------
# Analyze the script with PSScriptAnalyzer
#------------------------------------------------------------------------------------------------

## If you don't have ScriptAnalyzer installed, do so using:

Install-Module -Name PSScriptAnalyzer

# Once installed let it analyze your PSM1 file, which should handle the module.

Invoke-ScriptAnalyzer -Path ArcaneBooks.psm1

# Repair any errors until it produces no errors

#------------------------------------------------------------------------------------------------
# License
#------------------------------------------------------------------------------------------------

<#
If you created your module in GitHub, then you should select a license such as the MIT license.
If so you've already done this, otherwise you can find the text for a license and add it to your project.

Wikipedia has the text for many licenses, including the MIT License.
https://en.wikipedia.org/wiki/MIT_License
#>

#------------------------------------------------------------------------------------------------
# Test the publish for the module
#------------------------------------------------------------------------------------------------

# If you don't have PowerShellGet installed you'll need to do so.

Install-Module PowerShellGet

# Then you can import it

Import-Module PowerShellGet

# Now you can test the publish.
# Note, the apikey will be empty on GitHub, as they are sensitive.
# If you are using this as a template use your own.

$arcaneBooksApiKey = 'your key here'

# Be aware the folder the psm1 file is in must have the same name as the module
Publish-Module `
    -Path "D:\OneDrive\PSCore\ArcaneBooks\ArcaneBooks\ArcaneBooks" `
    -NuGetApiKey $arcaneBooksApiKey `
    -WhatIf `
    -Verbose

# Correct any errors, then try the test again.

#------------------------------------------------------------------------------------------------
# Publish the module
#------------------------------------------------------------------------------------------------

# Once all tests pass, you can publish for real.

Publish-Module `
    -Path "D:\OneDrive\PSCore\ArcaneBooks\ArcaneBooks\ArcaneBooks" `
    -NuGetApiKey $arcaneBooksApiKey

#------------------------------------------------------------------------------------------------
# Source
#------------------------------------------------------------------------------------------------

# https://jeffbrown.tech/how-to-publish-your-first-powershell-gallery-package/

Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Install-PackageProvider -Name PowerShellGet -Force -Scope CurrentUser
