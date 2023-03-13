# ArcaneBooks Project Overview

I am a member of the [Alabama Historical Radio Society](https://alhrs.org/). We are beginning a project to move our library into cloud based software named [PastPerfect](https://museumsoftware.com/). As part of this effort we'll be entering data for our extensive library into the software.

Naturally we want to automate as much of this as possible, since the collection is rather extensive. Some of our books are so old they have neither an ISBN or a Library of Congress Catalog Number (LCCN for short). Others have only the LCCN, the newer books have an ISBN, and a very few have both.

My goal with this project was to create a simple text files where a user can enter an LCCN into one file or the ISBN in another. That data will be piped through the appropriate cmdlets found in this module and produce a list of metadata for each book including things such as the book title, author, publication date, and the like.

The sources we'll use are the Library of Congress or the Open Library site, which is part of the Internet Archive. Both provide web APIs we can use to retrieve data.

The specifics of calling these APIs will be found in the appropriate files found in this documentation folder, specifically [Overview_ISBN.md](Overview_ISBN.md) and [Overview_LCCN.md](Overview_LCCN.md).

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
