class ISBNBook
{
    # Properties
    [string] $ISBN = ''
    [string] $ISBN10 = ''
    [string] $ISBN13 = ''
    [string] $Title = ''
    [string] $LCCN = ''
    [string] $Author = ''
    [string] $ByStatement = ''
    [string] $NumberOfPages = ''
    [string] $Publishers = ''
    [string] $PublishDate = ''
    [string] $PublisherLocation = ''
    [string] $Subject = ''
    [string] $LibraryOfCongressClassification = ''
    [string] $DeweyDecimalClass = ''
    [string] $Notes = ''
    [string] $CoverUrlSmall = ''
    [string] $CoverUrlMedium = ''
    [string] $CoverUrlLarge = ''

  # Default Constructor
  ISBNBook()
  { }


  [string] GetISBNBookData($ISBN)
  {

    # retMsg = Return Message
    $retMsg = "Beginning GetISBNBookData for $ISBN at $(Get-Date).ToString('yyyy-MM-dd hh:mm:ss tt')"

    $isbnFormatted = $ISBN.Replace('-', '').Replace(' ', '')
    $baseURL = "https://openlibrary.org/api/books?bibkeys=ISBN:"
    $urlParams = "&jscmd=data&format=json"

    $url = "$($baseURL)$($isbnFormatted)$($urlParams)"

    # Set the ISBN property to what was passed in
    $this.ISBN = $isbnFormatted

    # Try to get the ISBN data from the OpenLibrary website
    try {
      $bookData = Invoke-RestMethod $url
      $retMsg = "Retrieved ISBN $ISBN from OpenLibrary"
    }
    catch {
      $this.ISBN10 = '0'
      $this.ISBN13 = '0'
      $this.Title = "Failed to retrieve ISBN $ISBN. Possible internect connection issue."
      $retMsg = "Failed to retrieve ISBN $ISBN. Possible internect connection issue."
      return $retMsg
    }

    # Error handler for books not found
    if ($null -eq $bookData."ISBN:$isbnformatted")
    {
      $this.ISBN10 = '0'
      $this.ISBN13 = '0'
      $this.Title = "ISBN $ISBN was not found in the OpenLibrary.org database"
      $retMsg = "ISBN $ISBN was not found in the OpenLibrary.org database"
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

      # Books can have multiple authors, each is returned in its own item in an array.
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

      # All done! Set a success message.
      $retMsg = "Successfully retrieved data for ISBN $ISBN"
    }

    return $retMsg
  }

}
