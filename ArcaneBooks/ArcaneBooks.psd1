<#-------------------------------------------------------------------------------------------------
  ArcaneBooks - ArcaneBooks.psd1
  Author: Robert C. Cain | @ArcaneCode | arcane@arcanetc.com
           http://arcanecode.me

  This code is Copyright (c) 2023 Robert C. Cain. All rights reserved.

  The code herein is for demonstration purposes. No warranty or guarantee
  is implied or expressly granted.

  This module may not be reproduced in whole or in part without the express
  written consent of the author.
-----------------------------------------------------------------------------------------------#>

@{

  # Name of the module to process
  RootModule = 'ArcaneBooks.psm1'

  # Each module has to be uniquely identified. To do that PS uses a GUID.
  # To generate a GUID, use the New-Guid cmdlet and copy the result in here
  GUID = 'ba1e6fce-737b-48a6-adaa-1c6e0ed7811b'

  # Who wrote this module
  Author = 'Robert C. Cain (ArcaneCode)'

  # Company who made this module
  CompanyName = 'Arcane Training and Consulting'

  # Copyright
  Copyright = '(c) 2023 All rights reserved'

  # Description of the module
  Description = 'This module has cmdlets to retreive a books metadata (title, author, etc) based on either the ISBN or LCCN (Library of Congress Control Number)'

  # Version number for the module
  ModuleVersion = '0.9.4'

  # Minimum version of PowerShell needed to run this module
  PowerShellVersion = '7.0'

  # Min version of .NET Framework required
  DotNetFrameworkVersion = '2.0'

  # Min version of the CLR required
  CLRVersion = '2.0.50727'

  # These data files are used by the functions to hold additional data
  FileList = @()

  # Where can you find more info plus source code with documentation
  HelpInfoURI = 'https://github.com/arcanecode/ArcaneBooks/README.md'

  # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
  FunctionsToExport = @( 'Get-ISBNBookData',
                         'Get-LCCNBookData',
                         'Open-ABGitHub',
                         'Open-AboutArcaneCode',
                         'Show-AboutArcaneBooks',
                         'Show-AboutFunctions'
                       )

  # Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
  CmdletsToExport = @()

  # Variables to export from this module
  VariablesToExport = '*'

  # Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
  AliasesToExport = @( 'gisbn',
                       'glccn',
                       'ogit',
                       'oac',
                       'sab',
                       'saf'
                     )

  # Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
  PrivateData = @{

      PSData = @{

          # Tags applied to this module. These help with module discovery in online galleries.
          Tags = @('ISBN', 'LCCN', 'Books')

          # A URL to the license for this module.
          LicenseUri = 'https://github.com/arcanecode/ArcaneBooks/blob/main/LICENSE'

          # A URL to the main website for this project.
          ProjectUri = 'https://github.com/arcanecode/ArcaneBooks'

          # A URL to an icon representing this module.
          # IconUri = ''

          # ReleaseNotes of this module
          ReleaseNotes = 'https://github.com/arcanecode/ArcaneBooks/blob/main/README.md'

          # Prerelease string of this module
          # Prerelease = ''

          # Flag to indicate whether the module requires explicit user acceptance for install/update/save
          # RequireLicenseAcceptance = $false

          # External dependent modules of this module
          # ExternalModuleDependencies = @()

      } # End of PSData hashtable

  } # End of PrivateData hashtable

  # Supported PSEditions
  # CompatiblePSEditions = @()

  # Name of the PowerShell host required by this module
  # PowerShellHostName = ''

  # Minimum version of the PowerShell host required by this module
  # PowerShellHostVersion = ''

  # Processor architecture (None, X86, Amd64) required by this module
  # ProcessorArchitecture = ''

  # Modules that must be imported into the global environment prior to importing this module
  # RequiredModules = @()

  # Assemblies that must be loaded prior to importing this module
  # RequiredAssemblies = @()

  # Script files (.ps1) that are run in the caller's environment prior to importing this module.
  # ScriptsToProcess = @()

  # Type files (.ps1xml) to be loaded when importing this module
  # TypesToProcess = @()

  # Format files (.ps1xml) to be loaded when importing this module
  # FormatsToProcess = @()

  # Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
  # NestedModules = @()

  # DSC resources to export from this module
  # DscResourcesToExport = @()

  # List of all modules packaged with this module
  # ModuleList = @()


  # Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
  # DefaultCommandPrefix = ''
}