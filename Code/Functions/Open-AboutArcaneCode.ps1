<#
.SYNOPSIS
Opens the authors blog site to the "About Me" page with more information on his other projects.

.DESCRIPTION
This function provides a quick and easy way to open the the authors blog where you can learn more information about him and his other projects.

.INPUTS
This cmdlet has no inputs.

.OUTPUTS
Opens the ArcaneCode site for this module in your default browser.

.EXAMPLE
Open-AboutArcaneCode

.NOTES
ArcaneBooks - Open-AboutArcaneCode.ps1

Author: Robert C Cain | @ArcaneCode | arcane@arcanetc.com

This code is Copyright (c) 2023 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

.LINK
https://github.com/arcanecode/ArcaneBooks

.LINK
http://arcanecode.me
#>

function Open-AboutArcaneCode()
{

  Start-Process "https://arcanecode.com/info/"

}
