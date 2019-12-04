SELECT
 CustomAttribute1,
 AVG(Ctr) as avg_Ctr,
 AVG(ConversionRate) as avg_ConvRate,
 AVG(AverageCpc) as avg_AvgCPC,
 AVG(CAST(CustomAttribute2 as FLOAT64)) as avg_CustAttr2,
 SUM(Conversions) AS total_conversions,
 COUNT(DISTINCT(CategoryL1)) AS unique_products,
 COUNT(DISTINCT(Brand)) AS unique_Brands,
 COUNT(DISTINCT(Device)) AS unique_Device,
 COUNT(DISTINCT(ProductCondition)) AS unique_Condition,
 COUNT(DISTINCT(Date)) AS unique_days,
 SUM(Impressions) AS total_impressions,
 SUM(Clicks) AS total_clicks,
 SUM(ConversionValue) AS total_conversionvalue,
 SUM(Cost)/1000000 AS Cost_corrected,
 SUM(Clicks) / COUNT(DISTINCT(Date)) AS clicks_per_day,
 (SUM(ConversionValue)*1.3-(SUM(Cost)/1000000))*SUM(Clicks) AS Profit,
 SUM(ConversionValue)*1.3 as Revenue,
 period,
 CASE
	   WHEN SUM(ConversionValue)*1.3 <= 0 THEN 'none'
		 ELSE
			 'some'
		END
		 AS anyRevenue
		FROM (
			 SELECT
			   Ctr,
			   CustomAttribute1,
			   CustomAttribute0,
			   Date,
			   CategoryL1,
			   Impressions,
			   ConversionValue,
			   Cost,
			   Clicks,
			   ConversionRate,
			   AverageCpc,
			   CustomAttribute2,
			   Conversions,
			   Brand,
			   Device,
			   ProductCondition,
			   CASE
				     WHEN Date < '2019-05-20' THEN 'trial'
					   ELSE
						   'future'
						 END
						   AS period
						 FROM (
							   SELECT
							     CustomAttribute1,
							     CustomAttribute0,
							     Date,
							     CategoryL1,
							     Impressions,
							     ConversionValue,
							     Cost,
							     Clicks,
							     Ctr,
							     ConversionRate,
							     AverageCpc,
							     CustomAttribute2,
							     Conversions,
							     Brand,
							     Device,
							     ProductCondition
							   FROM
							     `redbrain-adtech.managed_ads_reports.ShoppingProductStats`
							   GROUP BY
							     AdGroupId,
							     AggregatorId,
							     CampaignId,
							     CountryCriteriaId,
							     ExternalCustomerId,
							     LanguageCriteriaId,
							     MerchantId,
							     OfferId,
							     AdNetworkType1,
							     AdNetworkType2,
							     AllConversionRate,
							     AllConversionValue,
							     AllConversions,
							     AverageCpc,
							     Brand,
							     CategoryL1,
							     CategoryL2,
							     CategoryL3,
							     CategoryL4,
							     CategoryL5,
							     Channel,
							     ChannelExclusivity,
							     Clicks,
							     ConversionRate,
							     ConversionValue,
							     Conversions,
							     Cost,
							     CostPerAllConversion,
							     CostPerConversion,
							     CrossDeviceConversions,
							     Ctr,
							     CustomAttribute0,
							     CustomAttribute1,
							     CustomAttribute2,
							     CustomAttribute3,
							     CustomAttribute4,
							     Date,
							     DayOfWeek,
							     Device,
							     Impressions,
							     Month,
							     ProductCondition,
							     ProductTypeL1,
							     ProductTypeL2,
							     ProductTypeL3,
							     ProductTypeL4,
							     ProductTypeL5,
							     Quarter,
							     SearchAbsoluteTopImpressionShare,
							     SearchClickShare,
							     SearchImpressionShare,
							     ValuePerAllConversion,
							     ValuePerConversion,
							     Week,
							     Year))
					WHERE
					 CustomAttribute1 <> '--'
					 AND CustomAttribute0 <> '--'
					 AND CAST(Clicks AS STRING) <> '--'
					 AND CAST(Impressions AS STRING) <> '--'
					 AND CAST(ConversionValue AS STRING) <> '--'
					 AND CAST(Cost AS STRING) <> '--'
					 AND CustomAttribute2 <> '--'
					GROUP BY
					 CustomAttribute1,
					 period
