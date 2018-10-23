# Weather Data with XSLT
### Flavour of XML, XSL, XSLT (Saxon-HE), SPARQL and Python

## Project Details
At first we are using an XSL stylesheet that extracts weather forecast information from different XML documents and transforms this information into an XHTML document with the help of the XSLT processor Saxon. The resulting XHTML document can be displayable in a Web browser with the help of a cascading sytlesheet (CSS) file.

Then, we have designed an RDFa vocabulary that can be used to augment the information in the XSL stylesheet so that the generated XHTML document can finally be queried via SPARQL from a Python script that uses Python's rdflib library. Details of the RDFa vocabulary is provided in separate file.

## Data
The following five XML documents is used in this project published by the Bureau of Meteorology that contain weather information for a specific time period:

* NSW and ACT (IDN10031.xml)
* Canberra (IDN10035.xml)
* New South Wales (IDN11050.xml)
* Sydney Metropolitan Area (IDN11060.xml)
* Snowy Mountains District Forecast (IDN11032.xml)

## XML, XSL and XSLT
Starting from the XML document IDN10031.xml, I have created an XSL stylesheet (weather-1.xsl) that extracts the relevant information from the XML documents and transforms this information into an XHTML document (weather-1.html) with the help of a CSS stylesheet (weather.css) using the XSLT processor Saxon-HE (home edition).

The resulting XHTML document should contain exactly the data elements as the XML file. This data present in a professional way on the XHTML page (weather-1.html).

Note that the XML document IDN10031.xml is the main document in this task and the other XML documents is accessed via the XSL stylesheet (weather.xsl). 

## RDFa with SPARQL Queries
 RDFa markup si added to the XHTML content so that it can automatically answer different types of SPARQL queries over the resulting XHTML document using a Python script.

Python script (weather.py) uses a bunch of different types of SPARQL queries to extract the relevant information from the XHTML document. The Python script should be able to fetch the XHTML document (weather-2.html) from an HTTP server. For this project, we will use a simple Python HTTP server that you can start up from the command line in the following way:
C:>python -m http.server 8085

The Python script (weather.py) should now be able to access the XHTML document via
http://localhost:8085/weather-2.html

The Python script should display the answers to the SPARQL queries on the standard output.


## Author
#### M TanVir Hossain

Software Engineer

Sydney, Australia

Email: hossain.tanvir.m@gmail.com

Originally this project was done by me in May, 2017. 
