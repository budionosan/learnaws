import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job

args = getResolvedOptions(sys.argv, ["JOB_NAME"])
sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args["JOB_NAME"], args)

datacatalog = glueContext.create_dynamic_frame.from_catalog(
    database = "finalthesisbudionosan",
    table_name = "mergeclean_csv",
    transformation_ctx = "datacatalog"
)

applymapping = ApplyMapping.apply(
    frame = datacatalog,
    mappings=[
        ("area", "string", "area", "string"),
        ("category", "string", "category", "string"),
        ("country", "string", "country", "string"),
        ("customer id", "string", "customer id", "string"),
        ("customer name", "string", "customer name", "string"),
        ("discount", "double", "discount", "double"),
        ("order date", "string", "order date", "string"),
        ("order id", "string", "order id", "string"),
        ("postal code", "int", "postal code", "int"),
        ("product id", "string", "product id", "string"),
        ("product name", "string", "product name", "string"),
        ("profit", "double", "profit", "double"),
        ("quantity", "int", "quantity", "int"),
        ("sales", "double", "sales", "double"),
        ("segment", "string", "segment", "string"),
        ("ship date", "string", "ship date", "string"),
        ("ship mode", "string", "ship mode", "string"),
        ("state", "string", "state", "string"),
        ("sub-category", "string", "sub-category", "string"),
    ],
    transformation_ctx = "applymapping",
)

redshift = glueContext.write_dynamic_frame.from_jdbc_conf(
	frame = applymapping, 
	catalog_connection = "AwsGlueDataBrew-finalthesisbudionosan", 
	connection_options = {"dbtable": "forecast", "database": "dev"}, 
	redshift_tmp_dir = args["TempDir"]
)

job.commit()