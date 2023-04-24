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
         Path is $PSScriptRoot
"@

  # Let user know we're done
  $et = Get-Date   # End Time
  Request-EndRunMessage -FunctionName $fn -StartTime $st -EndTime $et | Write-Verbose

  $aboutFunctions = @"


ArcaneBooks Module

Description

    This module is designed to return book metadata from either the ISBN number
    or the LCCN number.

---

ArcaneBooks Cmdlets

Get-ISBNBookData : https://github.com/arcanecode/ArcaneBooks/blob/main/Code/Help/Get-ISBNBookData.md

    Retrieves information for one or more books based on the ISBN number.

Get-LCCNBookData : https://github.com/arcanecode/ArcaneBooks/blob/main/Code/Help/Get-LCCNBookData.md

    Retrieves information for one or more books based on the LCCN (Library of Congress) number.

Show-AboutArcaneBooks : https://github.com/arcanecode/ArcaneBooks/blob/master/Documentation/Show-AboutArcaneBooks.md

    Displays information about the ArcaneBooks module, with links to find out more info.

Show-AboutFunctions : https://github.com/arcanecode/ArcaneBooks/blob/main/Code/Help/Show-AboutFunctions.md

    Displays a list of all the functions in the ArcaneBooks, along with a synopsis of their purpose.

Open-ABGitHub : https://github.com/arcanecode/ArcaneBooks/blob/main/Code/Help/Open-ABGitHub.md

    Opens the GitHub website for ArcaneBooks in your default browser.

Open-AboutArcaneCode : https://github.com/arcanecode/ArcaneBooks/blob/main/Code/Help/Open-AboutArcaneCode.md

    Opens the ArcaneCode blog to the "About Me" page to learn more about the author of ArcaneBooks.

---

Author Information

    Author: Robert C. Cain | @ArcaneCode : https://twitter.com/arcanecode) | arcanecode@gmail.com

    Websites

    About Me: http://arcanecode.me

    Blog: http://arcanecode.com

    Github: http://arcanerepo.com

    LinkedIn: http://arcanecode.in

Copyright Notice

    This document is Copyright (c) 2023 Robert C. Cain. All rights reserved.

    The code samples herein is for demonstration purposes. No warranty or guarantee is implied or expressly granted.

    This document may not be reproduced in whole or in part without the express written consent of the author and/or Pluralsight. Information within can be used within your own projects.

"@
  return $aboutFunctions

}
