# ISBN Overview

ISBN, or International Standard Book Number, is a 10 or 13 digit number used to uniquely identify a book. You can find more information on ISBNs at [https://www.isbn.org](https://www.isbn.org).

Every country has a service that creates an ISBN number for works created in that country, and cannot create numbers for books in other countries. ISBN's began in 1970 as a ten digit number. In 2007, due to a dwindling supply of numbers, it was switched to a thirteen digit number.

Thirteen digit numbers in the US currently begin with 978-0 and 978-1, and 979-8. For purposes of this module, though, we will be able to use either the ten or thirteen number version of the ISBN.

Publishers sometimes vary the format through the inclusion or exclusion of dashes or spaces to separate the parts of the ISBN. For our purposes this won't be relevant.

The data source we use (more on that momentarily) requires us to use only the number with no spaces or dashes. Thus the cmdlet in this module to fetch the ISBN data will remove any spaces or dashes from the number before it is used.

## Converting Between Ten and Thirteen Characters

It is possible, although not necessary for this module, to convert the ten digit ISBN to a thirteen digit one. The [https://www.isbn.org](https://www.isbn.org) website has an online converter which you'll find at [https://www.isbn.org/ISBN_converter](https://www.isbn.org/ISBN_converter).

There is also a good blog article at [The Postulate](https://thepostulate.com/converting-isbn-10-to-isbn-13/#:~:text=In%20simple%20terms%2C%20the%20process%20to%20convert%20from,ISBN-13%20numbers%20is%20an%20even%20multiple%20of%2010). In it the author gives an overview of how to convert from ten to thirteen character ISBNs, and provides code samples in Python.

Again, since our source can use either format of the ISBN, there are no plans at this time to implement the routine as PowerShell code.

## Data Source

In this module, we will use the [OpenLibrary.org](https://OpenLibrary.org) API to get our data. The OpenLibrary website is run by the Internet Archive.

Their API works in one of two ways. Whichever mode you choose, any dashes, spaces, etc must be removed before calling their URLs. Only a string of ten or thirteen numbers can be passed in.

In the first method, you can return an HTML webpage with the book data nicely formatted. The URL to access this is formatted like:

```
https://openlibrary.org/isbn/[isbn]
```

Where `[isbn]` is replaced by the ten or thirteen character ISBN number.

```
https://openlibrary.org/isbn/0672218747
```

Will bring up the book data for William Orr's **The Radio Handbook**.

We can also return the data in JSON format, which is what this module will do in order to accomplish its end result. To get the data in JSON, all we have to do is append `.json` to the url. This url will return the same book in JSON format.

```
https://openlibrary.org/isbn/0672218747.json
```

The OpenLibrary is flexible, you can use either the ten or thirteen digit number in the call. Both of these examples will bring up the same book.

```
https://openlibrary.org/isbn/0830678018.json
https://openlibrary.org/isbn/9780830678013.json
```

## Sample Data

For this module I've created some sample data you can use for testing. The [Sample_Data_Verification.md](Sample_Data_Verification.md) file has lists for both ISBN and LCCN data along with the book title they correspond to.

The file [Sample_Data_ISBN_Small.csv](Sample_Data_ISBN_Small.csv) has only the ISBNs stored as a CSV (Comma Separated Values) file.

## Conclusion

In this document we.... Understanding this information is important when we integrate the call into our PowerShell code.

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
