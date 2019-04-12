# Build GEOS Dependencies for AWS Lambda

If you're leveraging any of the Python tool sets that depend on the Open Source geometry toolkit [GEOS](https://trac.osgeo.org/geos/), 
such as Shapely, you may have some difficulties executing code within an AWS Lambda function.

You can deploy the GEOS dependencies as a layer within Lambda, allowing your Python code to execute with the 
correct C++ library code built for you.

This package creates a build environment based on the specific Amazon Linux version Lambda executes in. The 
Entrypoint script will export the build libraries to a zip file. All you need to do is upload as a layer to Lambda.

## Build Steps

1. Build the Docker container and libgeos
 - `$docker build -t libgeos-lambda-build:latest .`
 
2. Run the container and mount an output directory
 - ``$docker run -v `pwd`:/output libgeos-lambda-build:latest``
 - You should now have `libgeos-amzn-linux.zip`

3. Deploy the library as a layer to Lambda
 - You can now run Python code such as Shapely inside an AWS Lambda function!




