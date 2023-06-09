# LCCN Overview

## Introduction

The abbreviation **LCCN**, according to the Library of Congress's own website, stands for _Library of Congress Control Number_. When the system was first created in 1898, however,LCCN stood for _Library of Congress Card Number_, and I've seen it both way in publications.

The LCCN was created in 1898 to provide a unique value to every item in the Library of Congress. This not only includes books, but works of art, manuscripts (not in book form), maps, and more.

## LCCN Format

The LCCN has two parts, a prefix followed by a serial number. From 1898 to 2000 the prefix was two digits, representing the year. Beginning in 2001 the prefix became four digits, representing the year.

The serial number is simple a sequential number. 45-1 was the first number assigned in 1945. 45-1234 was the 1,234th item assigned in that year.

Be aware from 1969 to 1972 there was an experiment where the single digit of 7 was used for the prefix. They decided this scheme wasn't going to work out, and reverted to the standard format of year followed by serial number.

Here are a few examples of real LCCNs from books in my personal collection.

| LCCN | Title |
|-------|-------|
| 54-9698 | Elements of Radio Servicing |
| 40-33904 | Radio Handbook Twenty-Second Edition |
| 41-3345 | The Radio Amateur's Handbook 42nd Edition 1965 |
| 64-20875 | Early Electrical Communication |
| 74-75450 | VHF Handbook for Radio Amateurs |
| 76-190590 | Wire Antennas for Radio Amateurs |
| 71-120473 | 73 Vertical, Beam, and Triangle Antennas |

## Accessing Book Data from the Library of Congress

The Library of Congress actually provides two web APIs for getting book data. The first API is for accessing assets, such as digital assets. It doesn't return much data for books.

The second is the LC Z39.50 system, accessible through lx2.loc.gov. Here is an example of calling it to retrieve a record for the book **Elements of Radio Servicing**, which has the LCCN of 54-9698. (It should, of course, all be used as a single line just in case your web browser wraps it.)

```
http://lx2.loc.gov:210/lcdb?version=3&operation=searchRetrieve&query=bath.lccn=54009698&maximumRecords=1&recordSchema=mods
```

Breaking it down, the root call is to `http://lx2.loc.gov:210/lcdb`. After this is a question mark `?`, followed by the parameters.

The first parameter is `version=3`. This indicates which format to use for the return data. It supports two versions, 1.1 and 3. For our purposes we'll use the most current version, 3.

Following the ampersand `&` is `operation=searchRetrieve`. This instructs the Library of Congress's API that we want to do a search to retrieve data.

Next is the core piece, we need to tell it what LCCN number to look up, `query=bath.lccn=54009698`. The root object is `bath`, then it uses the property `lccn`.

The LCCN has to be formatted in a specific way. We start with the two or four digit year. In the above example, 54-9698, this would be the two digit year of `54`.

Next is the serial number. If the number is less than six digits, it must be left zero padded to become six. Thus 9698 becomes `009698`. The year and serial number are combined, removing any dashes, spaces, or other characters and becomes `54009698`.

Following is `maximumRecords=1`, indicating we only expect one record back. That's all we'll get back with a single LCCN anyway, so this will work fine for our needs.

The final parameter is `recordSchema=mods`. The API supports several formats.

| Record Schema | Description | Notes |
|-------|-------|-----|
| dc | Dublin Core (bibliographic records) | Brings back just the basics (Name, author, etc) |
| mads | MADS (authority records) | Brief, not a lot of info |
| mods | MODS (bibliographic records) | Very readable XML schema, most info |
| marcxml | MARCXML - the default schema | Abbreviated schema, not readable |
| opacxml | MARCXML (wth holdings attached) | As above with a bit more info |

You are welcome to experiment with different formats, but for this module we'll be using `mods`. It provides the most information, and is in XML. XML is very easy to read, and it works great with PowerShell.

## ISBN and Library of Congress

It is possible to use the Library of Congress to look up the ISBN. In my testing though, the interface provided by OpenLibrary provided more data. Thus we'll be using it for looking up ISBNs in this module.

You can read more about ISBNs in the file [Overview_ISBN.md](Overview_ISBN.md).

## Sample Data

For this module I've created some sample data you can use for testing. The [Sample_Data_Verification.md](Sample_Data_Verification.md) file has lists for both ISBN and LCCN data along with the book title they correspond to.

The file [Sample_Data_LCCN_Small.csv](Sample_Data_LCCN_Small.csv) has only the ISBNs stored as a CSV (Comma Separated Values) file.

## Conclusion

In this document we covered the basics of the LCCN as well as the web API provided by the Library of Congress. Understanding this information is important when we integrate the call into our PowerShell code.

Return to the [Overview](Overview.md).
Return to the root [ReadMe](./../README.md)

---

## Author Information

### Author

Robert C. Cain | [@ArcaneCode](https://twitter.com/arcanecode) | arcanecode@gmail.com

### Websites

About Me: [http://arcanecode.me](http://arcanecode.me)

Blog: [http://arcanecode.com](http://arcanecode.com)

Github: [http://arcanerepo.com](http://arcanerepo.com)

LinkedIn: [http://arcanecode.in](http://arcanecode.in)

### Copyright Notice

This document is Copyright (c) 2023 Robert C. Cain. All rights reserved.

The code samples herein is for demonstration purposes. No warranty or guarantee is implied or expressly granted.

This document may not be reproduced in whole or in part without the express written consent of the author and/or Pluralsight. Information within can be used within your own projects.
