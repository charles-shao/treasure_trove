GovHack 2013
==============

![Alt text](/app/assets/images/tt_logo.png)

A Trove x OpenCalais x DBpedia x Google Maps mashup.

We enhance the Trove newspaper article research experience by providing topic identification, named entity recognition, relation extraction, relevant supplementary information, and maps.

For newspaper article text we use the Trove API, which is then analysed using the OpenCalais service. This provides us with entities such as locations, people or organisations within the Trove data, which we use to enhance the contextual information available.

For the contextual information, we’ve included DBpedia integration, which allows the union of rich wiki-style data crossed with the basis provided by Trove. We provide spatial context to place mentions using Google Maps.

TreasureTrove is developed in Ruby on Rails, leveraging  Trove, OpenCalais, Google Maps, and DBpedia services with the potential to integrate many more.

TreasureTrove is released under the MIT License, see [LICENSE.txt](LICENSE.txt)
