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

# If the module is not in memory, then suppress the error and silently continue
# Note make sure you are in the code directory!
Remove-Module ArcaneBooks -ErrorAction SilentlyContinue
Import-Module D:\OneDrive\PSCore\ArcaneBooks\ArcaneBooks\Code\ArcaneBooks -Verbose

Clear-Host

#------------------------------------------------------------------------------------------------
# Helper Functions
#------------------------------------------------------------------------------------------------
Show-AboutArcaneBooks

# Pass in a single ISBN as a parameter
$ISBN = '0-87259-481-5'
$bookData = Get-ISBNBookData -ISBN $ISBN -Verbose
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


$ISBN = '1-887736-06-9'
$ISBN = '0-914126-02-4'

$ISBN = '978-1418065805'

    $rootURL = "https://openlibrary.org/isbn/"

    $isbnFormatted = $ISBN.Replace('-', '').Replace(' ', '')

    $url = "$($rootURL)$($isbnFormatted).json"

    $bookData = Invoke-RestMethod $url

    $bookData


$ISBN = '1-887736-06-9'
$ISBN = '0-914126-02-4'


$ISBN = '0-87259-481-5'

#--------------------------------------------------------

Remove-Module ArcaneBooks -ErrorAction SilentlyContinue
Import-Module D:\OneDrive\PSCore\ArcaneBooks\ArcaneBooks\Code\ArcaneBooks -Verbose

$ISBN = '978-0-9890350-5-7'
$bookData = $ISBN | Get-ISBNBookData -Verbose
$bookData


$ISBN = '978-1418065805'

  $isbnFormatted = $ISBN.Replace('-', '').Replace(' ', '')

  $url = "https://openlibrary.org/api/books?bibkeys=ISBN:$($isbnFormatted)&jscmd=data&format=json"

  $bookData = Invoke-RestMethod $url #-FollowRelLink$url

  $bookData

  $bookData."ISBN:$isbnformatted"

  $bookData."ISBN:$isbnformatted"
  $bookData."ISBN:$isbnformatted".identifiers

  $bookData."ISBN:$isbnformatted".identifiers
  $bookData."ISBN:$isbnformatted".identifiers.isbn_10
  $bookData."ISBN:$isbnformatted".identifiers.isbn_13

  $bookData."ISBN:$isbnformatted".authors.name

  $bookData."ISBN:$isbnformatted".classifications
  $bookData."ISBN:$isbnformatted".classifications.lc_classifications
  $bookData."ISBN:$isbnformatted".classifications.dewey_decimal_class

  $bookData."ISBN:$isbnformatted".publishers.name

  $bookData."ISBN:$isbnformatted".subjects

  $subjects = [System.Text.StringBuilder]::new()
  foreach ($s in $bookData."ISBN:$isbnformatted".subjects)
  {
    if ($subjects.Length -gt 1)
    { $subjects.Append(", $($s.name)") }
    else
    { [void]$subjects.Append($s.name) }
  }

  $subjects.ToString()

  $bookData."ISBN:$isbnformatted".ebooks
  $bookData."ISBN:$isbnformatted".cover

      if ($null -eq $bookData."ISBN:$isbnformatted".by_statement)
        { $ByStatement = '' }
      else
        { $ByStatement = $bookData."ISBN:$isbnformatted".by_statement.Replace('by ', '') }
   $ByStatement

  $bookData."ISBN:$isbnformatted".cover.small






#-----------------------------------------

$ISBN = '978-1418065805'
    $isbnFormatted = $ISBN.Replace('-', '').Replace(' ', '')

    $baseURL = "https://openlibrary.org/api/books?bibkeys=ISBN:"
    $urlParams = "&jscmd=data&format=json"


    $url = "$($baseURL)$($isbnFormatted)$($urlParams)"
Write-Host $url
    try {
      $bookData = Invoke-RestMethod $url
    }
    catch {
      Write-Host "Error calling $url $($Error.ToString())"
      return
    }

    # Error handler for books not found
    if ($bookData."ISBN:$isbnformatted".identifiers.isbn_10.Length -eq 0)
    {
      $this.ISBN10 = '0'
      $this.ISBN13 = '0'
      $this.Title = "ISBN $ISBN was not found in the OpenLibrary.org database "
      $this.LCCN = ''
      $this.ByStatement = ''

      $this.NumberOfPages = ''
      $this.PublishDate = ''
      $this.LibraryOfCongressClassification = ''
      $this.DeweyDecimalClass = ''
      $this.Notes = ''

      $this.CoverUrlSmall = ''
      $this.CoverUrlMedium = ''
      $this.CoverUrlLarge = ''

      $this.Author = ''
      $this.Subject = ''
      $this.Publishers = ''
      $this.PublisherLocation = ''

    }
    else # The book was found, assign the data
    {
      $this.ISBN10 = $bookData."ISBN:$isbnformatted".identifiers.isbn_10
      $this.ISBN13 = $bookData."ISBN:$isbnformatted".identifiers.isbn_13
      $this.Title = $bookData."ISBN:$isbnformatted".title
      $this.LCCN = $bookData."ISBN:$isbnformatted".identifiers.lccn

      # Remove the "by" (if present) at the beginning of the by statement
      # We need to check for null though, otherwise using Replace on a null string
      # will throw an error
      if ($null -eq $bookData."ISBN:$isbnformatted".by_statement)
        { $this.ByStatement = '' }
      else
        { $this.ByStatement = $bookData."ISBN:$isbnformatted".by_statement.Replace('by ', '') }

      $this.NumberOfPages = $bookData."ISBN:$isbnformatted".number_of_pages
      $this.PublishDate = $bookData."ISBN:$isbnformatted".publish_date
      $this.LibraryOfCongressClassification = $bookData."ISBN:$isbnformatted".classifications.lc_classifications
      $this.DeweyDecimalClass = $bookData."ISBN:$isbnformatted".classifications.dewey_decimal_class
      $this.Notes = $bookData."ISBN:$isbnformatted".notes

      $this.CoverUrlSmall = $bookData."ISBN:$isbnformatted".cover.small
      $this.CoverUrlMedium = $bookData."ISBN:$isbnformatted".cover.medium
      $this.CoverUrlLarge = $bookData."ISBN:$isbnformatted".cover.large

      # Books can have multiple authors, each is return in its own item in an array.
      # Combine them into a single string.
      $authors = [System.Text.StringBuilder]::new()
      foreach ($a in $bookData."ISBN:$isbnformatted".authors)
      {
        if ($authors.Length -gt 1)
          { [void]$authors.Append(", $($a.name)") }
        else
          { [void]$authors.Append($a.name) }
      }
      $xAuthor = $authors.ToString()

      # Subjects can be an array, combine into a single string
      $subjects = [System.Text.StringBuilder]::new()
      foreach ($s in $bookData."ISBN:$isbnformatted".subjects)
      {
        if ($subjects.Length -gt 1)
          { [void]$subjects.Append(", $($s.name)") }
        else
          { [void]$subjects.Append($s.name) }
      }
      $xSubject = $subjects.ToString()

      # A book could have multiple publishers over time. The author could shift to
      # a new publisher, or more likely a publishing house could be purchases and
      # the new owners name used. The data is returned as an array, so combine
      # them as we did with authors and subjects
      $thePublishers = [System.Text.StringBuilder]::new()
      foreach ($p in $bookData."ISBN:$isbnformatted".publishers)
      {
        if ($thePublishers.Length -gt 1)
          { [void]$thePublishers.Append(", $($p.name)") }
        else
          { [void]$thePublishers.Append($p.name) }
      }
      $xPublishers = $thePublishers.ToString()

      # Since there could be multiple publishers, logically there could be multiple
      # publishing locations. Combine them.
      $locations = [System.Text.StringBuilder]::new()
      foreach ($l in $bookData."ISBN:$isbnformatted".publish_places)
      {
        if ($locations.Length -gt 1)
          { [void]$locations.Append(", $($l.name)") }
        else
          { [void]$locations.Append($l.name) }
      }
      $xPublisherLocation = $locations.ToString()

    }


