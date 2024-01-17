""" Lambda function for generating positional data and
submitting it to an Amazon Location Service tracker. Used to simulate
vehicle movements for the solution. """

## Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
## SPDX-License-Identifier: MIT-0

# pylint: disable=import-error
import json
import logging
import os
import random
import datetime
import boto3
import botocore

# Set up Python logging.
logger = logging.getLogger()
logger.setLevel(logging.INFO)
# File used to configure simulated vehicles.
VEHICLES_FILE = "vehicles.json"
# Import environment variables from Lambda function.
tracker_name = os.environ["TRACKER_NAME"]
table_name = os.environ["TABLE_NAME"]
aws_region = os.environ["AWS_REGION"]
# Instantiate AWS clients.
als = boto3.client("location")
dynamodb = boto3.resource(
    "dynamodb",
    region_name=aws_region
)
table = dynamodb.Table(table_name)
# Open vehicles file and read in contents.
with open(VEHICLES_FILE, encoding="UTF-8") as vehicles_file:
    vehicles = json.loads(vehicles_file.read())
logger.info("Vehicle count: %s", str(len(vehicles)))

# pylint: disable=unused-argument,too-many-locals
def lambda_handler(event, context):
    """ Function to randomise vehicle location and send batch
    updates to Amazon Location Service tracker. """
    # Scan to see if there are previous locations stored in the table.
    try:
        scan_paginator = dynamodb.meta.client.get_paginator("scan")
        page_iterator = scan_paginator.paginate(
            TableName=table_name,
            ProjectionExpression="DeviceId, PositionData, SampleTime"
        )
    except botocore.exceptions.ClientError as error:
        logger.error("Error encountered: %s", str(error), exc_info=True)
    else:
        stored_vehicles = []
        for page in page_iterator:
            stored_vehicles.extend(page["Items"])
        stored_vehicle_locations = {}
        for stored_vehicle in stored_vehicles:
            stored_vehicle_locations[stored_vehicle["DeviceId"]] = {
                    "position": stored_vehicle["PositionData"],
                    "sample_time": stored_vehicle["SampleTime"]
                }
        logger.info(
                "Stored vehicle information found: %s",
                str(stored_vehicle_locations)
            )
    tracker_updates = []
    now = datetime.datetime.now()
    for vehicle in vehicles:
        # [Simulation] Generate random location offsets using base location.
        # Each 0.001 is approximately 111m.
        # Below code will provide max 0.1 variance (11.1km).
        base_lat = vehicle["base"][0]
        base_long = vehicle["base"][1]
        # Check if record of vehicle exists, and if it has update from today.
        if (
                (vehicle["name"] in stored_vehicle_locations) and
                (
                    stored_vehicle_locations[vehicle["name"]]["sample_time"][:10] ==
                    now.strftime("%Y-%m-%d")
                )
            ):
            base_latlong = json.loads(stored_vehicle_locations[vehicle["name"]]["position"])
            base_lat = base_latlong[0]
            base_long = base_latlong[1]
            logger.info("%s: found record from today.", vehicle["name"])
        else:
            logger.info(
                    "%s: no record from today. Resetting to base.",
                    vehicle["name"]
                )
        # Randomise location, using offset and random.triangular for variance.
        random_lat = round(
                (random.triangular(-1000, 0, 1000) / 10000) + base_lat,
                4
            )
        random_long = round(
                (random.triangular(-1000, 0, 1000) / 10000) + base_long,
                4
            )
        sample_time = now.strftime("%Y-%m-%dT%H:%M:%S.%fZ")
        tracker_updates.append(
            {
                "DeviceId": vehicle["name"],
                "Position": [random_long, random_lat],
                "SampleTime": sample_time
            }
        )
        # Store updated data back in DynamoDB table to ensure
        # realistic intra-day journey simulation.
        try:
            table.put_item(
                Item={
                    "DeviceId": vehicle["name"],
                    "PositionData": str([random_lat, random_long]),
                    "SampleTime": sample_time
                }
            )
        except botocore.exceptions.ClientError as error:
            logger.error("Error encountered: %s", str(error), exc_info=True)
    logger.info("Updates: %s", str(tracker_updates))
    # Update Amazon Location Service tracker with new device location.
    try:
        response = als.batch_update_device_position(
            TrackerName=tracker_name,
            Updates=tracker_updates
        )
        logger.info("ALS response: %s", str(response))
    except botocore.exceptions.ClientError as error:
        logger.error("Error encountered: %s", str(error), exc_info=True)
    status_code = 500
    if tracker_updates:
        status_code = 200
    return {
        "statusCode": status_code,
        "body": str(tracker_updates)
    }
