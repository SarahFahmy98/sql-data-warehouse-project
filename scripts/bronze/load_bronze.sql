
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

Create Or ALter Procedure bronze.load_bronze AS
BEGIN
	declare @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
	    set @batch_start_time=GETDATE();
		print '============================';
		print 'Loading Bronze Layer';
		print '============================';

		print 'Loading CRM Tables';
		print '============================';

		print 'Loading crm_cust_info table';
		set @start_time=GETDATE();
		Truncate Table bronze.crm_cust_info;

		Bulk Insert bronze.crm_cust_info 
		from 'C:\Users\imich\Downloads\DATAWAREHOUSE PROJECT\Sarah_Project\source_crm\cust_info.csv'
		with (
			Firstrow=2,
			Fieldterminator=',',
			Tablock
		);
		set @end_time=GETDATE();
		print '>> Load Duration: '+ cast(datediff(second,@start_time,@end_time) as nvarchar) + 'seconds'; 
		
		print'---------------------------';
		print 'Loading crm_prd_info table';
		set @start_time=GETDATE();
		Truncate Table bronze.crm_prd_info;

		Bulk Insert bronze.crm_prd_info 
		from 'C:\Users\imich\Downloads\DATAWAREHOUSE PROJECT\Sarah_Project\source_crm\prd_info.csv'
		with (
			Firstrow=2,
			Fieldterminator=',',
			Tablock
		);
		set @end_time=GETDATE();
		print '>> Load Duration: '+ cast(datediff(second,@start_time,@end_time) as nvarchar) + 'seconds'; 
		
		print'---------------------------';
		print 'Loading crm_sales_details table';
		set @start_time=GETDATE();
		Truncate Table bronze.crm_sales_details;

		Bulk Insert bronze.crm_sales_details 
		from 'C:\Users\imich\Downloads\DATAWAREHOUSE PROJECT\Sarah_Project\source_crm\sales_details.csv'
		with (
			Firstrow=2,
			Fieldterminator=',',
			Tablock
		);
	    set @end_time=GETDATE();
		print '>> Load Duration: '+ cast(datediff(second,@start_time,@end_time) as nvarchar) + 'seconds'; 
		
		print 'Loading ERP Tables';
		print '=======================';

		
		print 'Loading erp_cust_az12 table';
		set @start_time=GETDATE();
		Truncate Table bronze.erp_cust_az12;

		Bulk Insert bronze.erp_cust_az12 
		from 'C:\Users\imich\Downloads\DATAWAREHOUSE PROJECT\Sarah_Project\source_erp\cust_az12.csv'
		with (
			Firstrow=2,
			Fieldterminator=',',
			Tablock
		);
		set @end_time=GETDATE();
		print '>> Load Duration: '+ cast(datediff(second,@start_time,@end_time) as nvarchar) + 'seconds'; 
		
		print '---------------------------';
		print 'Loading erp_loc_a101 table';
		set @start_time=GETDATE();
		Truncate Table bronze.erp_loc_a101;

		Bulk Insert bronze.erp_loc_a101 
		from 'C:\Users\imich\Downloads\DATAWAREHOUSE PROJECT\Sarah_Project\source_erp\loc_a101.csv'
		with (
			Firstrow=2,
			Fieldterminator=',',
			Tablock
		);
		set @end_time=GETDATE();
		print '>> Load Duration: '+ cast(datediff(second,@start_time,@end_time) as nvarchar) + 'seconds'; 
		
		print '---------------------------';
		print 'Loading erp_px_cat_g1v2 table';
		set @start_time=GETDATE();
		Truncate Table bronze.erp_px_cat_g1v2;

		Bulk Insert bronze.erp_px_cat_g1v2 
		from 'C:\Users\imich\Downloads\DATAWAREHOUSE PROJECT\Sarah_Project\source_erp\px_cat_g1v2.csv'
		with (
			Firstrow=2,
			Fieldterminator=',',
			Tablock
		);
		set @end_time=GETDATE();
		print '>> Load Duration: '+ cast(datediff(second,@start_time,@end_time) as nvarchar) + 'seconds'; 
		
		set @batch_end_time=GETDATE();
		print '==============================================='
		print 'Loading Bronze Layer Completed'; 
		print 'Total Load Duration: '+ cast(datediff(second,@batch_start_time,@batch_end_time) as nvarchar) + 'seconds'; 
		print '==============================================='
		END TRY
	BEGIN CATCH
		print '====================='
		print ' ERROR OCCURED'
		print 'ERROR MESSAGE' + ERROR_MESSAGE();
		print '=====================';
	END CATCH
END
