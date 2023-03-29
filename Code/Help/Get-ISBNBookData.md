# Get-ISBNBookData

## SYNOPSIS

Gets book data from OpenLibrary.org based on the ISBN

## SYNTAX

```powershell
Get-ISBNBookData [-ISBN] <String> [<CommonParameters>]
```

## DESCRIPTION

Uses the more advanced API at OpenLibrary to retreived detailed informaiton
based on the 10 or 13 character ISBN passed in.

## EXAMPLES

### EXAMPLE 1

```powershell
# Pass in a single ISBN as a parameter
$ISBN = '0-87259-481-5'
$bookData = Get-ISBNBookData -ISBN $ISBN
$bookData
```

### EXAMPLE 2

```powershell
# Pipe in a single ISBN
$ISBN = '0-87259-481-5'
$bookData = $ISBN | Get-ISBNBookData
$bookData
```

### EXAMPLE 3

```powershell
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
```

Property | Value
| ----- | ------ |
$bookData | Select-Object -Property ISBN, Title

## PARAMETERS

### -ISBN

A 10 or 13 digit ISBN number.
The passed in value can have spaces or dashes,
it will remove them before processing the request to get the book data.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

Via the pipeline this cmdlet can accept an array of ISBN values.

## OUTPUTS

The cmdlet returns one or more objects of type Class ISBNBook with the
following properties. Note that not all properties may be present, it
depends on what data the publisher provided.

Property | Description
| ----- | ------ |
ISBN | The ISBN number that was passed in, complete with an formatting
ISBN10 | ISBN as 10 digits
ISBN13 | ISBN in 13 digit format
Title | The title of the book
LCCN | Library of Congress Catalog Number
Author | The author(s) of the book
ByStatement | The written by statement provided by the publisher
NumberOfPages | Number of pages in the book
Publishers | The Publisher(s) of this book
PublishDate | The publication date for this edition of the book
PublisherLocation | The location of the publisher
Subject | Generic subject(s) for the work
LibraryOfCongressClassification | Specialized classification used by Library of Congress
DeweyDecimalClass | Dewey Decimal number
Notes | Any additional information provided by the publisher
CoverUrlSmall | URL link to an image of the book cover, in a small size
CoverUrlMedium | URL link to an image of the book cover, in a medium size
CoverUrlLarge | URL link to an image of the book cover, in a large size

## NOTES

ArcaneBooks - Get-ISBNBookData.ps1

Author: Robert C Cain | [@ArcaneCode](https://twitter.com/arcanecode) | arcane@arcanetc.com

This code is Copyright (c) 2023 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

## RELATED LINKS

[https://github.com/arcanecode/ArcaneBooks/blob/main/Code/Help/Get-ISBNBookData.md](https://github.com/arcanecode/ArcaneBooks/blob/main/Code/Help/Get-ISBNBookData.md)

[ArcaneCode's Website](http://arcanecode.me)
