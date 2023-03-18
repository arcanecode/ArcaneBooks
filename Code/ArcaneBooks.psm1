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

class ISBNBook
{
    # Properties
    [string] $ISBN10
    [string] $ISBN13
    [string] $Title
    [string] $LCCN
    [string] $Author
    [string] $ByStatement
    [string] $NumberOfPages
    [string] $Publishers
    [string] $PublishDate
    [string] $PublisherLocation
    [string] $Subject
    [string] $LibraryOfCongressClassification
    [string] $DeweyDecimalClass
    [string] $Notes
    [string] $CoverUrlSmall
    [string] $CoverUrlMedium
    [string] $CoverUrlLarge

  # Default Constructor
  ISBNBook()
  { }


  [int] GetISBNBookData($ISBN)
  {

    $isbnFormatted = $ISBN.Replace('-', '').Replace(' ', '')

    $baseURL = "https://openlibrary.org/api/books?bibkeys=ISBN:"
    $urlParams = "&jscmd=data&format=json"

$retCode = 0

    $url = "$($baseURL)$($isbnFormatted)$($urlParams)"

    try {
      $bookData = Invoke-RestMethod $url
$retCode = 1
    }
    catch {
$retCode = 2
      Write-Host "Error calling $url $($Error.ToString())"
      return $retCode
    }

    # Error handler for books not found
    if ($null -eq $bookData."ISBN:$isbnformatted")
    {
$retCode = 3
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
$retCode = 4
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
      $this.Author = $authors.ToString()

      # Subjects can be an array, combine into a single string
      $subjects = [System.Text.StringBuilder]::new()
      foreach ($s in $bookData."ISBN:$isbnformatted".subjects)
      {
        if ($subjects.Length -gt 1)
          { [void]$subjects.Append(", $($s.name)") }
        else
          { [void]$subjects.Append($s.name) }
      }
      $this.Subject = $subjects.ToString()

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
      $this.Publishers = $thePublishers.ToString()

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
      $this.PublisherLocation = $locations.ToString()

    }
return $retCode
  }

}


#-----------------------------------------------------------------------------#

# Run the scripts to load data into memory. These need to be run prior to running the functions.
. ./Internal/Load-AboutMessages.ps1
. ./Internal/Request-EndRunMessage.ps1

# Run the scripts to load the functions into memory
. ./Functions/Show-AboutArcaneBooks.ps1
. ./Functions/Get-ISBNBookData.ps1

#-----------------------------------------------------------------------------#
# Export our functions
#-----------------------------------------------------------------------------#
Export-ModuleMember Show-AboutArcaneBooks
Export-ModuleMember Get-ISBNBookData
