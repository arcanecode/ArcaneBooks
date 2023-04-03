
# Set an ISBN to lookup - Title is "Your HF Digital Companion"

$ISBN = '0-87259-481-5'

# Now remove any spaces or dashes, then create the URL

$isbnFormatted = $ISBN.Replace('-', '').Replace(' ', '')
$baseURL = "https://openlibrary.org/api/books?bibkeys=ISBN:"
$urlParams = "&jscmd=data&format=json"
$url = "$($baseURL)$($isbnFormatted)$($urlParams)"

# Call the URL and put the data into a variable

$bookData = Invoke-RestMethod $url

# If we look at the data held by the variable, we get back a single column.
# That column holds JSON formatted data. (Note I truncated the XML for
# readability purposes.)

$bookData

# ISBN:0872594815
# ---------------
# @{url=https://openlibrary.org/books/OL894295M/Your_HF_digital_companion; key=/books/OL894295M; title=Your HF digital companion; authors=System.Object[]; number_of_pages=197; …

# We could address the data like:

$bookData.'ISBN:0872594815'.Title

# Note we had to wrap the ISBN number in quotes since a colon : isn't
# an allowed in property names. However, when we make the call the
# ISBN isn't set in stone.

# But we do have it in a variable, and we can use string interpolation to
# format the property

$bookData."ISBN:$isbnformatted".title

# This returns "Your HF digital companion". And yes, the words
# "digital" and "companion" should normally be capitalized, but
# this is the way the title comes from OpenLibrary.

# Now that we have the formatting down, we can get the other properties.
# Note that not all properties that are returned will have data.

$ISBN10 = $bookData."ISBN:$isbnformatted".identifiers.isbn_10
$ISBN13 = $bookData."ISBN:$isbnformatted".identifiers.isbn_13
$Title = $bookData."ISBN:$isbnformatted".title
$LCCN = $bookData."ISBN:$isbnformatted".identifiers.lccn
$NumberOfPages = $bookData."ISBN:$isbnformatted".number_of_pages
$PublishDate = $bookData."ISBN:$isbnformatted".publish_date
$LibraryOfCongressClassification = $bookData."ISBN:$isbnformatted".classifications.lc_classifications
$DeweyDecimalClass = $bookData."ISBN:$isbnformatted".classifications.dewey_decimal_class
$Notes = $bookData."ISBN:$isbnformatted".notes
$CoverUrlSmall = $bookData."ISBN:$isbnformatted".cover.small
$CoverUrlMedium = $bookData."ISBN:$isbnformatted".cover.medium
$CoverUrlLarge = $bookData."ISBN:$isbnformatted".cover.large

# The ByStatement sometimes begins with the word "By ". If so we want
# to remove it. However if we try and do a replace and the by_statement
# column is null, attempting to do a replace will result in an error.
# So first we have to check for null, and only if the by_statement isn't
# null do we attempt to do a replace.

if ($null -eq $bookData."ISBN:$isbnformatted".by_statement)
  { $ByStatement = '' }
else
  { $ByStatement = $bookData."ISBN:$isbnformatted".by_statement.Replace('by ', '') }

# For the remaining data, each item can have multiple entries attached.
# For example, a book could have multiple authors. For our purposes we
# will just combine into a single entry.

# We'll create a new variable of type StringBuilder, then loop over the
# list of items in the JSON, combining them into a single string.

# In the if, we check to see if the string already has data, if so
# we append a comma before adding the second (or more) authors name.

# Finally we use the ToString method of the StringBuilder class to
# convert the value back into a standard string data type.

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
$Author = $authors.ToString()

# Subjects can be an array, combine into a single string

$subjects = [System.Text.StringBuilder]::new()
foreach ($s in $bookData."ISBN:$isbnformatted".subjects)
{
  if ($subjects.Length -gt 1)
    { [void]$subjects.Append(", $($s.name)") }
  else
    { [void]$subjects.Append($s.name) }
}
$Subject = $subjects.ToString()

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
$Publishers = $thePublishers.ToString()

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
$PublisherLocation = $locations.ToString()

# Now print out all the returned data
$ISBN10
$ISBN13
$Title
$LCCN
$NumberOfPages
$PublishDate
$LibraryOfCongressClassification
$DeweyDecimalClass
$Notes
$CoverUrlSmall
$CoverUrlMedium
$CoverUrlLarge
$ByStatement
$Author
$Subject
$Publishers
$PublisherLocation

<#
Here is the output, manually formatted for easier reading.

ISBN10: 95185134
ISBN13: <null>
Title: Your HF digital companion
LCCN: <null>
Number of Pages: 197
Publish Date: 1995
LibraryOfCongressClassification: TK5745 .F572 1995
DeweyDecimalClass: 004.6/4
Notes: Includes bibliographical references.
Based on: Your RTTY/AMTOR companion. 1st ed. c1993.
CoverUrlSmall: https://covers.openlibrary.org/b/id/12774631-S.jpg
CoverUrlMedium: https://covers.openlibrary.org/b/id/12774631-M.jpg
CoverUrlLarge: https://covers.openlibrary.org/b/id/12774631-L.jpg
ByStatement: Steve Ford.
Author: Steve Ford
Subject: Radiotelegraph, Amateurs' manuals
Publishers: American Radio Relay League
PublisherLocation: Newington, CT
#>

