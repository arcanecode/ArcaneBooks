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
      $retCode = $book.GetISBNBookData($ISBN)
Write-Verbose "Return Code $retCode"
      Write-Verbose "Fetched Data for $($book.ISBN10) - $($book.Title)"
    }

    Write-Verbose "Returning the book object to you"
    return $book

  }

}