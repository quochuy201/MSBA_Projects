# CAPSTONE PROJECT:
# USING MACHINE LEARNING ALGORITHMS TO ANALYZE IMPACT OF CRIME ON PROPERTY VALUES
Instructor: Ben Kim
<br>Authors:
- Preslav Angelov
- Huy Le
- Evin Tolentino

Research paper: <a href= "http://www.iacis.org/iis/2020/1_iis_2020_55-61.pdf">USING MACHINE LEARNING ALGORITHMS TO ANALYZE IMPACT OF CRIME ON PROPERTY VALUES</a>

## Summary
There are many factors influencing the sale price of private properties. In this project, we focus on how different types of crimes affect the residential property sale price in an urban county in the USA - Pierce County, Washington. We are interested in what machine learning algorithms can be more effective in predicting the sales values. We worked on two sets of data. The first data source includes the physical attributes of a property, such as the square footage, quality, the year built and/or remodeled. The second data source contains the crime data for Pierce County from July 2018 to July 2019.

## What did we do?
1. Research questions:
  - Does different type of crime have different affect on a private property value?
  - Does number of crime affect on property value?
  - Which specific crime would affect on which property?

2. Methodologies:
  - The most difficult problem in this project is how to integrate crime data into property data or how we evaluate the commuity safety of a property due to crime data. Former researchs have various ways to integrate these data. It depends on their data attributes. However, our datasets dont have any clear connection (e.g zipcode, street, city), instead we have latitude and longitude of the crime incident and private property. Therefore, to integrate crime data into property data for evaluating community safety of properties, we connect them by distance. If a crime occurred within one mile radius area from the property, this crime was counted in the crime attribute of the property.
  - The second problem is that our method above required a tremendous number of calculation. We had approximately 20,000 rows for properties and 27,000 rows for crime. this would lead to approximately a half-billion calculations to obtain the entire data set of properties and crime in Pierce County. Due to the constraints of time and resources, we reduced our crime data by randomly selecting ten percent of the original properties dataset.
