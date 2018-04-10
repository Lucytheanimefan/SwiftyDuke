# SwiftyDuke

A Swift 4 library designed to connect to the API's maintained by the Innovation Co-lab at Duke University.

## The APIs

Social Media -- The SDSocial wrapper class provides access points to the social media API. You can use the SDSocial.shared() singleton to access the data provided. We provide 3 different ways to get this data: all of the data at once, filtered by a search term, and filtered by the media source (Twitter, Facebook).

Identity -- The SDIdentityManager wrapper class provides access points to the identity APIs. With these, you can search for a person affiliated with Duke by their unique netID, uniqueID, or name. These functions look at massive amounts of data, so filtering them out tends to work best.

Curriculum -- The SDCurriculum wrapper class provides access points to to curriculum that Duke offers. To use this API, you may pass in subject terms and get courses back, or you may pass in course IDs and get information about that course back.

Places -- The SDPlaceManager wrapper class provides access to the places API. This gives information about places on Duke's campus. You can use it in several different ways: simply getting the place categories, getting a place for a specific tag, or getting a place for a specific ID.

Authentication -- You may authenticate a user on the Duke network by using the SDAuthenticate wrapper class. The method requires a clientID and a redirectURI.

