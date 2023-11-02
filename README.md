
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# CORS error while accessing S3 bucket.
---

This incident type relates to encountering a Cross-Origin Resource Sharing (CORS) error while trying to access an S3 object from a bucket. In order to troubleshoot this issue, it is necessary to ensure that the CORS configuration is properly set on the bucket and that the request headers match the allowed origin, method, and headers specified in the configuration. The recommended steps include verifying the presence of the Origin header, capturing the complete request and response, and checking that the method and headers in the request align with the allowed values in the CORS rule.

### Parameters
```shell
export BUCKET_NAME="PLACEHOLDER"

export ALLOWED_ORIGIN="PLACEHOLDER"

export S3_OBJECT_URL="PLACEHOLDER"

export ALLOWED_METHOD="PLACEHOLDER"

export ALLOWED_HEADER="PLACEHOLDER"
```

## Debug

### Verify the CORS configuration of a bucket
```shell
aws s3api get-bucket-cors --bucket ${BUCKET_NAME}
```

### Check if the Origin header in the request matches the allowed origin in the CORS configuration
```shell
curl -I -H "Origin: ${ALLOWED_ORIGIN}" ${S3_OBJECT_URL}
```

### Check if the method in the request matches the allowed method in the CORS configuration
```shell
curl -I -X ${ALLOWED_METHOD} ${S3_OBJECT_URL}
```

### Check if the headers in the request match the allowed headers in the CORS configuration
```shell
curl -I -H "Origin: ${ALLOWED_ORIGIN}" -H "Access-Control-Request-Method: ${ALLOWED_METHOD}" -H "Access-Control-Request-Headers: ${ALLOWED_HEADER}" -X OPTIONS ${S3_OBJECT_URL}
```

## Repair

### Update the CORS configuration to match the expected values.Verify that the CORS configuration is properly set on the bucket.
```shell


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


```