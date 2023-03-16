<#
.SYNOPSIS
This function does nothing more than display additional information about the ArcaneBooks module.

.DESCRIPTION
Simply displays additional information on where users can find more information on the ArcaneBooks module.

.INPUTS
This cmdlet has no inputs.

.OUTPUTS
The cmdlet creates an array of one or more objects with the following properties

.EXAMPLE
Show-AboutArcaneBooks

Shows the info about this module.

.NOTES
ArcaneBooks - Show-AboutArcaneBooks.ps1

Author: Robert C Cain | @ArcaneCode | arcane@arcanetc.com

This code is Copyright (c) 2023 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Show-AboutDataFabricator.md

.LINK
http://arcanecode.me

#>

function Show-AboutArcaneBooks()
{
  [CmdletBinding()]
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

  return $m_aboutArcaneBooks

}
