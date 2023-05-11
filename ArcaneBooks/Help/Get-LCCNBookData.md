# Get-LCCNBookData

## SYNOPSIS

Gets book data from the Library of Congress based on the LCCN (Library of Congress Catalog Number)

## SYNTAX

```powershell
Get-LCCNBookData [-LCCN] <String> [<CommonParameters>]
```

## DESCRIPTION

Calls the public web API at the library of congress using the LCCN number.

## EXAMPLES

### EXAMPLE 1

```powershell
# Pass in a single LCCN as a parameter
$LCCN = '54009698'
$bookData = Get-LCCNBookData -LCCN $LCCN
$bookData
```

### EXAMPLE 2

```powershell
# Pipe in a single ISBN
$LCCN = '54009698'
$bookData = $LCCN | Get-LCCNBookData
$bookData
```

### EXAMPLE 3

```powershell
# Pipe in an array of LCCNs
$LCCNs = @( '54-9698'
          , '40-33904'
          , '41-3345'
          , '64-20875'
          , '74-75450'
          , '76-190590'
          , '71-120473'
          )
$bookData = $LCCNs | Get-LCCNBookData -Verbose
$bookData
```

Property | Value
| ----- | ------ |
$bookData | Select-Object -Property LibraryOfCongressNumber, Title

## PARAMETERS

### -LCCN

The LCCN number.
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

Via the pipeline this cmdlet can accept an array of LCCN values.

## OUTPUTS

The cmdlet returns one or more objects of type Class LCCNBook with the
following properties. Note that not all properties may be present, it
depends on what data the publisher provided.

Property | Description
| ----- | ------ |
LCCN | The LCCN that the user passed into the function
LibraryOfCongressNumber | The LCCN from the LCCN site
Title | The title of the book
Author | The book author(s)
PublisherLocation | The location(s) of the Publisher(s)
Publishers | The name(s) of the publishers
PublishDate | The publication date
Subject | The subject(s) for the book
LibraryOfCongressClassification | The classification from the library of congress
Description | The book description, usually has the page number
Edition | The edtion for this book

## NOTES

ArcaneBooks - Get-LCCNBookData.ps1

Author: Robert C Cain | [@ArcaneCode](https://twitter.com/arcanecode) | arcane@arcanetc.com

This code is Copyright (c) 2023 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

## RELATED LINKS

[https://github.com/arcanecode/ArcaneBooks/blob/1ebe781951f1a7fdf19bb6731487a74fa12ad08b/ArcaneBooks/Help/Get-LCCNBookData.md](https://github.com/arcanecode/ArcaneBooks/blob/1ebe781951f1a7fdf19bb6731487a74fa12ad08b/ArcaneBooks/Help/Get-LCCNBookData.md)

[ArcaneCode's Website](http://arcanecode.me)
