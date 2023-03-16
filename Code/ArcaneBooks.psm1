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
    [string] $CreatedDate
    [string] $LastModifiedDate
    [string] $PublisherLocation
    #[string] $Contributors
    [string] $EditionName
    [string] $Subject
    [string] $RevisionNumber
    [string] $LatestRevisionNumber
    [string] $Notes

  # Default Constructor
  ISBNBook()
  { }


  [void] GetISBNBookData($ISBN)
  {
    $rootURL = "https://openlibrary.org/isbn/"

    $isbnFormatted = $ISBN.Replace('-', '').Replace(' ', '')

    $url = "$($rootURL)$($isbnFormatted).json"

    $bookData = Invoke-RestMethod $url

    # Error handler for books not found
    if ($null -eq $bookData)
    {
      $this.ISBN = $ISBN
      $this.Title = 'Book Not Found'
      $this.LCCN = ''
      $this.ByStatement = ''
      $this.NumberOfPages = ''
      $this.Publishers = ''
      $this.PublishDate = ''
      $this.CreatedDate = ''
      $this.LastModifiedDate = ''
      $this.PublisherLocation = ''
      #$this.Contributors = $bookData.contributions
      $this.Subject = ''
      $this.RevisionNumber = ''
      $this.LatestRevisionNumber = ''
      $this.Notes = ''

      # Clean up the edition name
      $this.EditionName = ''

      # Try to extract just the author name by removing the "by"
      $this.Author = ''
    }
    else
    {
      $this.ISBN10 = $bookData.isbn_10
      $this.ISBN13 = $bookData.isbn_13
      $this.Title = $bookData.title
      $this.LCCN = $bookData.lccn
      $this.ByStatement = $bookData.by_statement
      $this.NumberOfPages = $bookData.number_of_pages
      $this.Publishers = $bookData.publishers
      $this.PublishDate = $bookData.publish_date
      $this.CreatedDate = $bookData.created.value
      $this.LastModifiedDate = $bookData.last_modified.value
      $this.PublisherLocation = $bookData.publish_places
      #$this.Contributors = $bookData.contributions
      $this.Subject = $bookData.subjects
      $this.RevisionNumber = $bookData.revision
      $this.LatestRevisionNumber = $bookData.latest_revision
      $this.Notes = $bookData.notes.value

      # Clean up the edition name
      if ($null -eq $bookData.edition_name)
      { $this.EditionName = ''}
      else
      { $this.EditionName = $bookData.edition_name.Replace('[','').Replace(']','').Replace('..', '.') }

      # Try to extract just the author name by removing the "by"
      if ($null -eq $bookData.by_statement)
      { $this.Author = '' }
      else
      { $this.Author = $bookData.by_statement.Replace('by ', '').Replace('.', '') }
    }

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
