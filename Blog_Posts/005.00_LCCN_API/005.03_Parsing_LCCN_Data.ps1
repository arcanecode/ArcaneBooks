
# This is the LCCN for "Elements of radio servicing" by William Marcus
$LCCN = '54-9698'

# First we need to remove any non digits.
$lccnCleaned = $LCCN.Replace('-', '').Replace(' ', '')

# Now get the first two characters which represent the year
$lccnPrefix = $lccnCleaned.Substring(0,2)

# Digits 0 and 1 were the year. Start from the third digit (in position 2)
# and go to the end of the string, getting the characters.
# Then, left pad what is there with 0's to make it six digits.
$lccnPadded = $lccnCleaned.Substring(2).PadLeft(6, '0')

# Now combine the reformatted LCCN and save it as a property
$lccnFormatted ="$($lccnPrefix)$($lccnPadded)"

# Now combine all the parts to create the URL
$baseURL = "http://lx2.loc.gov:210/lcdb?version=3&operation=searchRetrieve&query=bath.lccn="
$urlParams = "&maximumRecords=1&recordSchema=mods"
$url = "$($baseURL)$($lccnFormatted)$($urlParams)"

# Try to get the LCCN data from the Library of Congress site
try {
  $bookData = Invoke-RestMethod $url
}
catch {
  Write-Host "Failed to retrieve LCCN $LCCN. Possible internect connection issue. Script exiting." `
    -ForegroundColor Red
  # If there's an error, quit running the script
  exit
}

# Now we need to see if the book was found in the archive. If not the title will be null.
# We let the user know, and skip the rest of the script
if ($null -eq $bookData.searchRetrieveResponse.records.record.recordData.mods.titleInfo.title)
{
  Write-Host = "Retrieving LCCN $LCCN returned no data. The book was not found."
}
else # Great, the book was found, assign the data to variables
{
  $LibraryOfCongressNumber = $bookData.searchRetrieveResponse.records.record.recordData.mods.identifier.'#text'
  $Title = $bookData.searchRetrieveResponse.records.record.recordData.mods.titleInfo.title
  $PublishDate = $bookData.searchRetrieveResponse.records.record.recordData.mods.originInfo.dateIssued.'#text'
  $LibraryOfCongressClassification = $bookData.searchRetrieveResponse.records.record.recordData.mods.classification.'#text'
  $Description = $bookData.searchRetrieveResponse.records.record.recordData.mods.physicalDescription.extent
  $Edition = $bookData.searchRetrieveResponse.records.record.recordData.mods.originInfo.edition

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
  $Author = $authors.ToString()

  # Subjects can be an array, combine into a single string
  $subjects = [System.Text.StringBuilder]::new()
  $topics = $bookData.searchRetrieveResponse.records.record.recordData.mods.subject | Select topic
  foreach ($s in $topics.topic)
  {
    if ($subjects.Length -gt 1)
      { [void]$subjects.Append(", $($s)") }
    else
      { [void]$subjects.Append($s) }
  }
  $Subject = $subjects.ToString()

  # A book could have multiple publishers over time. The author could shift to
  # a new publisher, or more likely a publishing house could be purchases and
  # the new owners name used. The data is returned as an array, so combine
  # them as we did with authors and subjects.

  # Note that in the returned data, the publisher is stored as an "agent". We'll
  # use the name Publisher to keep it consistent with the ISBN code.
  $thePublishers = [System.Text.StringBuilder]::new()
  foreach ($p in $bookData.searchRetrieveResponse.records.record.recordData.mods.originInfo.agent)
  {
    if ($thePublishers.Length -gt 1)
      { [void]$thePublishers.Append(", $($p.namePart)") }
    else
      { [void]$thePublishers.Append($p.namePart) }
  }
  $Publishers = $thePublishers.ToString()

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
  $PublisherLocation = $locations.ToString()

  # All done! Set a success message.
  Write-Host "Successfully retrieved data for LCCN $LCCN" -ForegroundColor Green

  ## Display the results. Note some fields may not have data
  "LCCN: $LCCN"
  "Formatted LCCN: $lccnFormatted"
  "Library Of Congress Number: $LibraryOfCongressNumber"
  "Title: $Title"
  "Publish Date: $PublishDate"
  "Library Of Congress Classification: $LibraryOfCongressClassification"
  "Description: $Description"
  "Edition: $Edition"
  "Author: $Author"
  "Subject: $Subject"
  "Publishers: $Publishers"
  "Publisher Location: $PublisherLocation"
}

