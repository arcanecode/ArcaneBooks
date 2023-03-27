<#
.SYNOPSIS
Gets book data from OpenLibrary.org based on the ISBN

.DESCRIPTION
Uses the more advanced API at OpenLibrary to retreived detailed informaiton
based on the 10 or 13 character ISBN passed in.

.PARAMETER ISBN
A 10 or 13 digit ISBN number. The passed in value can have spaces or dashes,
it will remove them before processing the request to get the book data.

.INPUTS
Via the pipeline this cmdlet can accept an array of ISBN values.

.OUTPUTS
The cmdlet returns one or more objects of type Class ISBNBook with the
following properties:
ISBN
ISBN10
ISBN13
Title
LCCN
Author
ByStatement
NumberOfPages
Publishers
PublishDate
PublisherLocation
Subject
LibraryOfCongressClassification
DeweyDecimalClass
Notes
CoverUrlSmall
CoverUrlMedium
CoverUrlLarge

.EXAMPLE
# Pass in a single ISBN as a parameter
$ISBN = '0-87259-481-5'
$bookData = Get-ISBNBookData -ISBN $ISBN
$bookData

.EXAMPLE
# Pipe in a single ISBN
$ISBN = '0-87259-481-5'
$bookData = $ISBN | Get-ISBNBookData
$bookData

.EXAMPLE
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

.NOTES
ArcaneBooks - Get-ISBNBookData.ps1

Author: Robert C Cain | @ArcaneCode | arcane@arcanetc.com

This code is Copyright (c) 2023 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/CMDLET-HERE.md

.LINK
http://arcanecode.me
#>

function Get-ISBNBookData()
{
  [CmdletBinding()]
  param (
         [Parameter( Mandatory = $true,
                     ValueFromPipeline = $true,
                     HelpMessage = 'Please enter the ISBN.'
                     )]
         [string] $ISBN
        )

  process
  {
    foreach($number in $ISBN)
    {
      Write-Verbose 'Creating the Book Object'
      $book = [ISBNBook]::new()

      Write-Verbose "Getting the book data for ISBN $ISBN"
      $retMsg = $book.GetISBNBookData($ISBN)
      Write-Verbose "Calling GetISBNBookData returned a message of: $retMsg"
      Write-Verbose "Finished Getting Data for $($ISBN) - $($book.Title)"
    }

    Write-Verbose "Returning the book object to you"
    return $book

  }

}