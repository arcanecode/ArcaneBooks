<#-------------------------------------------------------------------------------------------------
  ArcaneBooks - ArcaneBooks.psm1
  Author: Robert C. Cain | @ArcaneCode | arcane@arcanetc.com
           http://arcanecode.me

  This code is Copyright (c) 2023 Robert C. Cain. All rights reserved.

  The code herein is for demonstration purposes. No warranty or guarantee
  is implied or expressly granted.

  This module may not be reproduced in whole or in part without the express
  written consent of the author.
-----------------------------------------------------------------------------------------------#>

# Run the scripts to load data into memory. These need to be run prior to running the functions.
. "$PSScriptRoot/Internal/Request-EndRunMessage.ps1"

# Load the classes
. "$PSScriptRoot/Functions/Class_ISBNBook.ps1"
. "$PSScriptRoot/Functions/Class_LCCNBook.ps1"

# Run the scripts to load the functions into memory
. "$PSScriptRoot/Functions/Get-ISBNBookData.ps1"
. "$PSScriptRoot/Functions/Get-LCCNBookData.ps1"
. "$PSScriptRoot/Functions/Open-ABGitHub.ps1"
. "$PSScriptRoot/Functions/Open-AboutArcaneCode.ps1"
