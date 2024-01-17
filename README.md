# Gain insights from historical location data using Amazon Location Service and AWS analytics services #

## Overview ##

Many organizations around the world rely on the use of physical assets, such as vehicles, to deliver a service to the end customer. By tracking these assets in real-time, and storing the results, owners can derive valuable insights on how they are being utilized to continuously deliver business improvements, and to plan for future changes. For example, a delivery company operating a fleet of vehicles will need to ascertain what the impact might be from local policy changes outside of their control, such as the announced expansion of an [Ultra Low Emission Zone (ULEZ)](https://en.wikipedia.org/wiki/Ultra_Low_Emission_Zone). By combining historical vehicle location data with information from other sources, the organization can devise empirical approaches to drive better decision making. For example, this information can be used by the company’s procurement team to make decisions about which vehicles to prioritize for replacement before policy changes come into force.

Using [Amazon Location Service support for publishing device position updates to Amazon EventBridge](https://aws.amazon.com/about-aws/whats-new/2023/07/amazon-location-service-device-updates-eventbridge/), developers can build a near real-time data pipeline that stores locations of tracked assets in Amazon S3. Additionally, using AWS Lambda, incoming location data can be enriched using data from other sources, such as an Amazon DynamoDB table containing vehicle maintenance details. It is then possible for a data analyst to use [Athena’s geospatial querying capabilities](https://docs.aws.amazon.com/athena/latest/ug/querying-geospatial-data.html) to gain insights, such as the number of days their vehicles have operated in the proposed boundaries of an expanded ULEZ. Since vehicles that do not meet ULEZ emissions standards are subjected to a daily charge to operate within the zone, location data, alongside maintenance data such as age of vehicle, current mileage and whether a particular vehicle meets current emissions standards, can be used to estimate the amount the company would have spent on daily fees.

This post shows you how you can use Amazon Location, EventBridge, Lambda, Amazon Kinesis Data Firehose, and S3 to build a location-aware data pipeline, and use this data to drive meaningful insights using AWS Glue and Athena.

![Solution architecture](images/architecture_diagram_v0.5.png)

Figure 1: Solution architecture

## AWS Blog post ##

This approach is fully documented in the following blog post:

`TBC`
