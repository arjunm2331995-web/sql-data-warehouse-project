/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '===============================================';
		PRINT 'LOADIND BRONZE LAYER';
		PRINT '===============================================';

		PRINT '-----------------------------------------------';
		PRINT 'LOADIND CRM TABLES';
		PRINT '-----------------------------------------------';

		SET @start_time = GETDATE();
		PRINT'TRUNCATING TABLE : bronze.crm_cust_info'
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT'INSERTING DATA INTO :bronze.crm_cust_info'
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\Hp\Downloads\SQL warehouse\dbc9660c89a3480fa5eb9bae464d6c07\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'LOAD DURATION :' + CAST (DATEDIFF (second,@start_time,@end_time) AS NVARCHAR) +'seconds';
		PRINT '---------------------';
		
		SET @start_time = GETDATE();
		PRINT'TRUNCATING TABLE : bronze.crm_prd_info'
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT'INSERTING DATA INTO :bronze.crm_prd_info'
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\Hp\Downloads\SQL warehouse\dbc9660c89a3480fa5eb9bae464d6c07\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'LOAD DURATION :' + CAST (DATEDIFF (second,@start_time,@end_time) AS NVARCHAR) +'seconds';
		PRINT '---------------------';

		SET @start_time = GETDATE();
		PRINT'TRUNCATING TABLE : bronze.sale_detail'
		TRUNCATE TABLE bronze.sale_detail;
		PRINT'INSERTING DATA INTO :bronze.sale_detail'
		BULK INSERT bronze.sale_detail
		FROM 'C:\Users\Hp\Downloads\SQL warehouse\dbc9660c89a3480fa5eb9bae464d6c07\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'LOAD DURATION :' + CAST (DATEDIFF (second,@start_time,@end_time) AS NVARCHAR) +'seconds';
		PRINT '---------------------';
	
		PRINT '-----------------------------------------------';
		PRINT 'LOADIND ERP TABLES';
		PRINT '-----------------------------------------------';
	
		SET @start_time = GETDATE();
		PRINT'TRUNCATING TABLE : bronze.erp_cust_az12'
		TRUNCATE TABLE bronze.erp_cust_az12;
		PRINT'INSERTING DATA INTO :bronze.erp_cust_az12'
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\Hp\Downloads\SQL warehouse\dbc9660c89a3480fa5eb9bae464d6c07\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'LOAD DURATION :' + CAST (DATEDIFF (second,@start_time,@end_time) AS NVARCHAR) +'seconds';
		PRINT '---------------------';
	
		SET @start_time = GETDATE();
		PRINT'TRUNCATING TABLE : bronze.erp_loc_a101'
		TRUNCATE TABLE bronze.erp_loc_a101;
		PRINT'INSERTING DATA INTO :bronze.erp_loc_a101'
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\Hp\Downloads\SQL warehouse\dbc9660c89a3480fa5eb9bae464d6c07\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'LOAD DURATION :' + CAST (DATEDIFF (second,@start_time,@end_time) AS NVARCHAR) +'seconds';
		PRINT '---------------------';
	
		SET @start_time = GETDATE();
		PRINT'TRUNCATING TABLE : bronze..px_cat_g1v2'
		TRUNCATE TABLE bronze.px_cat_g1v2;
		PRINT'INSERTING DATA INTO :bronze.px_cat_g1v2'
		BULK INSERT bronze.px_cat_g1v2
		FROM 'C:\Users\Hp\Downloads\SQL warehouse\dbc9660c89a3480fa5eb9bae464d6c07\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'LOAD DURATION :' + CAST (DATEDIFF (second,@start_time,@end_time) AS NVARCHAR) +'seconds';
		PRINT '---------------------';
	
		SET @batch_end_time = GETDATE();
		PRINT 'LOAD DURATION FOR BRONZE LAYER IS :' + CAST(DATEDIFF(second,@batch_start_time,@batch_end_time) AS NVARCHAR) + 'seconds';
	END TRY

	BEGIN CATCH
		PRINT '=============================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT 'ERROR MESSAGE :'+ ERROR_MESSAGE();
		PRINT 'ERROR MESSAGE :'+ CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'ERROR MESSAGE :'+ CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '=============================================';
	END CATCH
	
END
