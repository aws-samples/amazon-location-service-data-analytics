""" Lambda function for processing incoming positional payloads from
Amazon Location Service, by enriching them, and storing them in a S3 bucket.
External vehicle maintenance data is expected in a DynamoDB table. """

## Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
## SPDX-License-Identifier: MIT-0

# pylint: disable=import-error
import json
import logging
import os
import uuid
import boto3
import botocore

# Set up Python logging.
logger = logging.getLogger()
logger.setLevel(logging.INFO)
# Import environment variables from Lambda function.
bucket_name = os.environ["S3_BUCKET_NAME"]
bucket_prefix = os.environ["S3_BUCKET_PREFIX"]
table_name = os.environ["DYNAMODB_TABLE"]
aws_region = os.environ["AWS_REGION"]
# Instantiate AWS clients.
s3 = boto3.client("s3")
dynamodb = boto3.resource(
    "dynamodb",
    region_name=aws_region
)
table = dynamodb.Table(table_name)

# pylint: disable=unused-argument,too-many-locals
def lambda_handler(event, context):
    """ Function to process incoming positional data from Amazon Location
    Service and commit this data to a S3 bucket. """
    logger.info(event)
    status_code = 500
    response_body = {"s3_object": ""}
    try:
        device_id = event["DeviceId"]
        # Retrieve additional vehicle details from a DynamoDB table.
        maintenance_record = {}
        try:
            maintenance_record = table.get_item(Key={"DeviceId": device_id})
            if "Item" in maintenance_record:
                maintenance_record = maintenance_record["Item"]
        except botocore.exceptions.ClientError as error:
            logger.error("Error encountered: %s", str(error), exc_info=True)
        # If records are found in an external table, enrich the payload with
        # the data. Ignore, if not.
        if "MeetsEmissionStandards" in maintenance_record:
            event["MeetsEmissionStandards"] = maintenance_record["MeetsEmissionStandards"]
        if "PurchaseDate" in maintenance_record:
            event["PurchaseDate"] = maintenance_record["PurchaseDate"]
        if "Mileage" in maintenance_record:
            event["Mileage"] = int(maintenance_record["Mileage"])
        # Commit the payload to a S3 bucket with desired prefix and object name.
        # bucket_prefix should not have a trailing /.
        # pylint: disable=consider-using-f-string
        key = "%s/%s/%s-%s.json" % (
                bucket_prefix, event["DeviceId"],
                event["SampleTime"],
                str(uuid.uuid4())
            )
        body = json.dumps(event, separators=(",", ":"))
        body_encoded = body.encode("utf-8")
        s3.put_object(Bucket=bucket_name, Key=key, Body=body_encoded)
        # Successfully processed payload.
        logger.info("Transformed event saved as %s.", str(key))
        logger.info("Transformed event content: %s", str(body))
        status_code = 200
        response_body = {"s3_object": str(key)}
    except Exception as error:      # pylint: disable=broad-except
        logger.error("Error encountered: %s", str(error), exc_info=True)
    return {
        "statusCode": status_code,
        "body": json.dumps(response_body)
    }
