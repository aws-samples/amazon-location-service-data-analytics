""" Simple utility used to convert GeoJSON polygon features into
ST_Polygon strings that can be used in an Athena PostGis query. Run directly
from command line. Output is printed in the console. """

## Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
## SPDX-License-Identifier: MIT-0

# pylint: disable=import-error

import json
import logging

# Set up Python logging.
logger = logging.getLogger()
logger.setLevel(logging.INFO)

# GeoJSON file location.
GEOJSON_FILE = "../Ultra_Low_Emissions_Zone_Expansion.json"

# pylint: disable=too-many-nested-blocks
def main():
    """ Function to convert all coordinates into ST_Polygon strings. """
    try:
        with open(GEOJSON_FILE) as file:
            geojson =  json.load(file)
    except FileNotFoundError as error:
        logger.error("GeoJSON file not found.\n\n%s", str(error), exc_info=True)
    else:
        try:
            for feature in geojson["features"]:
                if feature["type"] == "Feature" and feature["geometry"]["type"] == "Polygon":
                    st_polygon_coordinates = "ST_Polygon('polygon(("
                    for all_coordinates in feature["geometry"]["coordinates"]:
                        for coordinates in all_coordinates:
                            st_polygon_coordinates += str(coordinates[0]) + \
                                                      " " + \
                                                      str(coordinates[1]) + ","
                    # Remove last comma from string.
                    st_polygon_coordinates = st_polygon_coordinates[:-1]
                    # Add closing brackets.
                    st_polygon_coordinates += "))')\n"
                    print(st_polygon_coordinates)
        except KeyError as error:
            logger.error("GeoJSON format not supported.\n\n%s", str(error), exc_info=True)

if __name__ == "__main__":
    main()
