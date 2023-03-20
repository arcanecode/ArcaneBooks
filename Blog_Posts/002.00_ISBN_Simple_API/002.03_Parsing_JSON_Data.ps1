
# Set the URL and call the API via Invoke-RestMethod
# The returned JSON data will be held in the variable $BookData
$url = 'https://openlibrary.org/isbn/0672218747.json'
$bookData = Invoke-RestMethod $url

# Here is an extract of part of the JSON code.
# Below we'll show how to access it with PowerShell

<#
   ...more json here
   "title": "Radio Handbook",
   "number_of_pages": 1168,
   ...more json follows
#>

# Here we can just use the variable holding the returned JSON,
# then dot notation to access the property we want
# We're also using string interpolation. Because we are accessing
# properties of an object, we have to wrap it in $()
"Title: $($bookData.title)"
"Number Of Pages: $($bookData.number_of_pages)"

# Identifiers is a JSON object with two values, goodreads and librarything

<#
   ...more json here
   "identifiers": {
     "goodreads": [
       "3084620"
     ],
     "librarything": [
       "1522789"
     ]
   },
   ...more json follows
#>

# We can get the data by just using additional dot notation after the
# identifiers object
"GoodReads Number: $($bookData.identifiers.goodreads)"
"LibraryThing Number: $($bookData.identifiers.librarything)"


# Subjects is returned as a JSON array within the Subjects property

<#
   ...more json here
  "subjects": [
    "Radio",
    "Technology & Industrial Arts"
  ],
   ...more json follows
#>

# You can deal with these in two ways.
# First, you can list individually
foreach ($s in $bookData.subjects)
{
  "Subject: $s"
}

# In the second method you could combine in a single string

# Start by creating a StringBuilder object to append the strings
# as efficiently as possible
$mySubjects = [System.Text.StringBuilder]::new()

# Loop over the BookData Subjects array, copying the current
# subject into the variable $s
foreach ($s in $bookData.subjects)
{
  if ($mySubjects.Length -gt 1)
  {
    # If we already have data in our StringBuilder $mySubjects,
    # then add a comma first, then the name of the subject from $s
    [void]$mySubjects.Append(", $($s)")
  }
  else
  {
    # If the length of our StringBuilder variable is less than 1,
    # it's empty so we'll just append the name of the subject without
    # a comma in front
    [void]$mySubjects.Append($s)
  }
}

# We need to convert the StringBuilder to a normal String to
# use it effectively, for example as a property in a class
$myCombinedSubjects = $mySubjects.ToString()
"Combined Subjects: $myCombinedSubjects"

# The created and last_modified properties are objects,
# simliar to the identifiers

<#
   ...more json here
  "created": {
    "type": "/type/datetime",
    "value": "2008-04-29T15:03:11.581851"
  },
  "last_modified": {
    "type": "/type/datetime",
    "value": "2022-02-16T09:26:53.493088"
  }
   ...more json follows
#>

# For both of these we only need the value property, so we can
# just ignore the type
"Created: $($bookData.created.value)"
"Last Modified: $($bookData.last_modified.value)"
