<#-------------------------------------------------------------------------------------------------
  ArcaneBooks - ArcaneBooks_Usage.ps1
  Author: Robert C. Cain | @ArcaneCode | arcane@arcanetc.com
           http://arcanecode.me

  This code is Copyright (c) 2023 Robert C. Cain. All rights reserved.

  This script simply demonstrates how to use the ArcaneBooks Module. It's a bunch of test
  commands I used during development. I've left it here in case you want to explore
  ArcaneBooks.

  The code herein is for demonstration purposes. No warranty or guarantee
  is implied or expressly granted.

  This module may not be reproduced in whole or in part without the express
  written consent of the author.
-----------------------------------------------------------------------------------------------#>

# Note, this PowerShell script is designed to run individual lines of code for testing.
# Highlighting individual line(s) and pressing F8 to run just those lines.

# Old habits die hard, and sometimes you hit F5 by accident. The line below will exit the
# script, should you hit F5.
if ( 1-eq 1 ) { exit }

#------------------------------------------------------------------------------------------------
# First, remove the module from memory if it's loaded. This is needed
# if you are making changes and want to test those changes.
#------------------------------------------------------------------------------------------------

# On my system when I open the project it goes to D:\OneDrive\PSCore\ArcaneBooks.
# You need to be in the actual Code folder for things such as Removing or Importing the module,
# generating help, etc to work. So I added a quick change to the Code folder here, mostly
# so I don't forget.
Set-Location .\ArcaneBooks

# If the module is not in memory, then suppress the error and silently continue
# Note make sure you are in the code directory!
Remove-Module ArcaneBooks -ErrorAction SilentlyContinue
Import-Module D:\OneDrive\PSCore\ArcaneBooks\ArcaneBooks\ArcaneBooks\ArcaneBooks -Verbose

Clear-Host

#------------------------------------------------------------------------------------------------
# Working with ISBNs
#------------------------------------------------------------------------------------------------

# Pass in a single ISBN as a parameter
$ISBN = '0-87259-481-5'
$bookData = Get-ISBNBookData -ISBN $ISBN -Verbose
$bookData

# Test Alias
$ISBN = '0-87259-481-5'
$bookData = gisbn -ISBN $ISBN -Verbose
$bookData

# Pipe in a single ISBN
$ISBN = '0-87259-481-5'
$bookData = $ISBN | Get-ISBNBookData -Verbose
$bookData

$ISBN = '978-0-9890350-5-7'
$bookData = $ISBN | Get-ISBNBookData -Verbose
$bookData

# Pipe in an array of ISBNs
$ISBNs = @( '0-87259-481-5'
          , '0-8306-7801-8'
          , '0-8306-6801-2'
          , '0-672-21874-7'
          , '0-07-830973-5'
          , '978-1418065805'
          , '1418065803'
          , '978-0-9890350-5-7'
          , '1-887736-06-9'
          , '0-914126-02-4'
          , '978-1-4842-5930-6'
          )
$bookData = $ISBNs | Get-ISBNBookData -Verbose
$bookData

$bookData | Select-Object -Property ISBN, Title

#------------------------------------------------------------------------------------------------
# Working with LCCNs
#------------------------------------------------------------------------------------------------

Remove-Module ArcaneBooks -ErrorAction SilentlyContinue
Import-Module D:\OneDrive\PSCore\ArcaneBooks\ArcaneBooks\ArcaneBooks\ArcaneBooks -Verbose

# Pass in a single LCCN as a parameter
$LCCN = '54009698'
$bookData = Get-LCCNBookData -LCCN $LCCN -Verbose
$bookData

# Alias
$LCCN = '54009698'
$bookData = glccn -LCCN $LCCN -Verbose
$bookData

# Pipe in a single ISBN
$LCCN = '54-9698'
$bookData = $LCCN | Get-LCCNBookData
$bookData

.EXAMPLE
# Pipe in an array of LCCNs
$LCCNs = @( '54-9698'
          , '40-33904'
          , '41-3345'
          , '64-20875'
          , '74-75450'
          , '76-190590'
          , '71-120473'
          )
$bookData = $LCCNs | Get-LCCNBookData -Verbose
$bookData

$bookData | Select-Object -Property LCCNReformatted, Subject, LibraryOfCongressClassification, Title

#------------------------------------------------------------------------------------------------
# Informational Functions and Help
#------------------------------------------------------------------------------------------------
Remove-Module ArcaneBooks -ErrorAction SilentlyContinue
Import-Module D:\OneDrive\PSCore\ArcaneBooks\ArcaneBooks\ArcaneBooks\ArcaneBooks -Verbose

# Display information about this module
Get-Help about_ArcaneBooks

# Display the list of functions
Get-Help about_ABFunctions

# Show Usage Notes
Get-Help about_ABUsage

# Open the GitHub site for this project in your default browser
Open-ABGitHub

# alias
ogit

# Open the "About Me" page on the module authors website
Open-AboutArcaneCode

# alias
oac
