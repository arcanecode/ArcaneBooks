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
  ModuleToProcess = 'ArcaneBooks.psm1'

  # Each module has to be uniquely identified. To do that PS uses a GUID.
  # To generate a GUID, use the New-Guid cmdlet and copy the result in here
  GUID = 'ba1e6fce-737b-48a6-adaa-1c6e0ed7811b'

  # Who wrote this module
  Author = 'Robert C. Cain'

  # Company who made this module
  CompanyName = 'Arcane Training and Consulting'

  # Copyright
  Copyright = '(c) 2023 All rights reserved'

  # Description of the module
  Description = 'Tools to retreive book metadata'

  # Version number for the module
  ModuleVersion = '0.1.1'

  # Minimum version of PowerShell needed to run this module
  PowerShellVersion = '7.0'

  # Min version of .NET Framework required
  DotNetFrameworkVersion = '2.0'

  # Min version of the CLR required
  CLRVersion = '2.0.50727'

  # These data files are used by the functions to hold additional data
  FileList = @( './Internal/Data-AboutFunctions.txt',
                './Internal/Data-AboutMessage.txt'
              )

  # Where can you find more info plus source code with documentation
  HelpInfoURI = 'https://github.com/arcanecode/ArcaneBooks/README.md'

}