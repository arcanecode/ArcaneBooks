class LCCNBook
{
    # Properties
    [string] $LCCN = ''
    [string] $LCCNReformatted = ''
    [string] $LibraryOfCongressNumber = ''
    [string] $Title = ''
    [string] $Author = ''
    [string] $PublisherLocation = ''
    [string] $Publishers = ''
    [string] $PublishDate = ''
    [string] $Subject = ''
    [string] $LibraryOfCongressClassification = ''
    [string] $Description = ''
    [string] $Edition = ''

  # Default Constructor
  ISBNBook()
  { }


  [string] GetLCCNBookData($LCCN)
  {

    # retMsg = Return Message
    $retMsg = "Beginning GetLCCNBookData for $LCCN at $(Get-Date).ToString('yyyy-MM-dd hh:mm:ss tt')"

    # First we need to remove any non digits. Then pad the ending to six digits
    $lccnCleaned = $LCCN.Replace('-', '').Replace(' ', '')
    $lccnPrefix = $lccnCleaned.Substring(0,2)
    $lccnPadded = $lccnCleaned.Substring(2).PadLeft(6, '0')

    # Now combine the reformatted LCCN and save it as a property
    $lccnFormatted ="$($lccnPrefix)$($lccnPadded)"
    $this.LCCNReformatted = $lccnFormatted

    # Create the URL
    $baseURL = "http://lx2.loc.gov:210/lcdb?version=3&operation=searchRetrieve&query=bath.lccn="
    $urlParams = "&maximumRecords=1&recordSchema=mods"

    $url = "$($baseURL)$($lccnFormatted)$($urlParams)"

    # Set the LCCN property to what was passed in
    $this.LCCN = $LCCN

    # Try to get the ISBN data from the OpenLibrary website
    try {
      $bookData = Invoke-RestMethod $url
      $retMsg = "Retrieved LCCN $LCCN from Library of Congress"
    }
    catch {
      $this.LibraryOfCongressNumber = '0'
      $this.Title = "Failed to retrieve LCCN $LCCN. Possible internect connection issue."
      $retMsg = "Failed to retrieve LCCN $LCCN. Possible internect connection issue."
      return $retMsg
    }

    # Error handler for books not found
    if ($null -eq $bookData.searchRetrieveResponse.records.record.recordData.mods.titleInfo.title)
    {
      $this.LibraryOfCongressNumber = '0'
      $this.Title = "Failed to retrieve LCCN $LCCN. Possible internect connection issue."
      $retMsg = "Failed to retrieve LCCN $LCCN. Possible internect connection issue."
    }
    else # The book was found, assign the data
    {
      $this.LibraryOfCongressNumber = $bookData.searchRetrieveResponse.records.record.recordData.mods.identifier.'#text'
      $this.Title = $bookData.searchRetrieveResponse.records.record.recordData.mods.titleInfo.title
      $this.PublishDate = $bookData.searchRetrieveResponse.records.record.recordData.mods.originInfo.dateIssued.'#text'
      $this.LibraryOfCongressClassification = $bookData.searchRetrieveResponse.records.record.recordData.mods.classification.'#text'
      $this.Description = $bookData.searchRetrieveResponse.records.record.recordData.mods.physicalDescription.extent
      $this.Edition = $bookData.searchRetrieveResponse.records.record.recordData.mods.originInfo.edition

      # Books can have multiple authors, each is returned in its own item in an array.
      # Combine them into a single string.
      $authors = [System.Text.StringBuilder]::new()
      foreach ($a in $bookData.searchRetrieveResponse.records.record.recordData.mods.name)
      {
        if ($authors.Length -gt 1)
          { [void]$authors.Append(", $($a.namePart)") }
        else
          { [void]$authors.Append($a.namePart) }
      }
      $this.Author = $authors.ToString()

      # Subjects can be an array, combine into a single string
      $subjects = [System.Text.StringBuilder]::new()
      foreach ($s in $bookData.searchRetrieveResponse.records.record.recordData.mods.subject)
      {
        if ($subjects.Length -gt 1)
          { [void]$subjects.Append(", $($s.topic)") }
        else
          { [void]$subjects.Append($s.topic) }
      }
      $this.Subject = $subjects.ToString()

      # A book could have multiple publishers over time. The author could shift to
      # a new publisher, or more likely a publishing house could be purchases and
      # the new owners name used. The data is returned as an array, so combine
      # them as we did with authors and subjects
      $thePublishers = [System.Text.StringBuilder]::new()
      foreach ($p in $bookData.searchRetrieveResponse.records.record.recordData.mods.originInfo.agent)
      {
        if ($thePublishers.Length -gt 1)
          { [void]$thePublishers.Append(", $($p.namePart)") }
        else
          { [void]$thePublishers.Append($p.namePart) }
      }
      $this.Publishers = $thePublishers.ToString()

      # Since there could be multiple publishers, logically there could be multiple
      # publishing locations. Combine them.
      $locations = [System.Text.StringBuilder]::new()
      foreach ($l in $bookData.searchRetrieveResponse.records.record.recordData.mods.originInfo.place.placeTerm)
      {
        if ($locations.Length -gt 1)
          { [void]$locations.Append(", $($l.'#text')") }
        else
          { [void]$locations.Append($l.'#text') }
      }
      $this.PublisherLocation = $locations.ToString()

      # All done! Set a success message.
      $retMsg = "Successfully retrieved data for LCCN $LCCN"
    }

    return $retMsg
  }

}
