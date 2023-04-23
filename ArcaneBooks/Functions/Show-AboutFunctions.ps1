<#
.SYNOPSIS
This function does nothing more than display the list of functions the ArcaneBooks module.

.DESCRIPTION
Displays a list of functions along with a brief overview of each.

The displayed data comes from the Data-AboutFunctions.txt file in the Internal folder.

.INPUTS
This cmdlet has no inputs.

.OUTPUTS
There are no outputs for this cmdlet

.EXAMPLE
Show-AboutFunctions

Shows the functions included in this module.

.NOTES
ArcaneBooks - Show-AboutFunctions.ps1

Author: Robert C Cain | @ArcaneCode | arcane@arcanetc.com

This code is Copyright (c) 2023 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

.LINK
https://github.com/arcanecode/ArcaneBooks/blob/master/Documentation/Show-AboutFunctions.md

.LINK
http://arcanecode.me

#>

function Show-AboutFunctions()
{
  [CmdletBinding()]
  [alias("saf")]
  param (
        )

  $fn = "$($PSCmdlet.MyInvocation.MyCommand.Module) - $($PSCmdlet.MyInvocation.MyCommand.Name)"
  $st = Get-Date

  Write-Verbose @"
$fn
         Starting at $($st.ToString('yyyy-MM-dd hh:mm:ss tt'))
"@

  # Let user know we're done
  $et = Get-Date   # End Time
  Request-EndRunMessage -FunctionName $fn -StartTime $st -EndTime $et | Write-Verbose

  return $m_aboutFunctions

}
