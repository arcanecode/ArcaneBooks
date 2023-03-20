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