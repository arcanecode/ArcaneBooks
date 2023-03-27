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
following properties:
ISBN
ISBN10
ISBN13
Title
LCCN
Author
ByStatement
NumberOfPages
Publishers
PublishDate
PublisherLocation
Subject
LibraryOfCongressClassification
DeweyDecimalClass
Notes
CoverUrlSmall
CoverUrlMedium
CoverUrlLarge

## NOTES

ArcaneBooks - Get-ISBNBookData.ps1

Author: Robert C Cain | [@ArcaneCode](https://twitter.com/arcanecode) | arcane@arcanetc.com

This code is Copyright (c) 2023 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

## RELATED LINKS

[https://github.com/arcanecode/DataFabricator/blob/master/Documentation/CMDLET-HERE.md](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/CMDLET-HERE.md)

[ArcaneCode's Website](http://arcanecode.me)
