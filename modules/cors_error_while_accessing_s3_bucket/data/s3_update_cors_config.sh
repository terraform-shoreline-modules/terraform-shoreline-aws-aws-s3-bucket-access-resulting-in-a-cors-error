

#!/bin/bash



# Set variables

BUCKET_NAME=${BUCKET_NAME}



echo '{

  "CORSRules": [

    {

      "ID": "CORSRule1",

      "AllowedHeaders": ["*"],

      "AllowedMethods": ["GET", "PUT", "POST", "DELETE"],

      "AllowedOrigins": ["*"],

      "ExposeHeaders": ["x-amz-meta-custom-header"],

      "MaxAgeSeconds": 3000

    }

  ]

}' > cors-config.json





# Update CORS configuration if necessary

aws s3api put-bucket-cors --bucket $BUCKET_NAME --cors-configuration file://cors-config.json



# Verify updated CORS configuration

aws s3api get-bucket-cors --bucket $BUCKET_NAME