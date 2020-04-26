
set -x

MAIN_HOURLY_SOURCE_DIR="/scratch-shared/edwinsu/era5-land_meteo/hourly/"

YEAR=2017
YEAR_PLUS_1=2018

OUTPUT_FOLDER="/scratch-shared/edwinsu/era5-land_meteo/without_remapcon/wind_speed_10m/"
OUTPUT_FOLDER=${OUTPUT_FOLDER}/${YEAR}
mkdir -p ${OUTPUT_FOLDER}

#~ edwinsu@tcn741.bullx:/scratch-shared/edwinsu/era5-land_meteo/hourly$ ls -lah  
#~ total 56K
#~ dr-xr-xr-x 6 edwinsu edwinsu 4.0K Apr 23 22:46 .
#~ drwxr-xr-x 3 edwinsu edwinsu 4.0K Apr 23 22:46 ..
#~ dr-xr-xr-x 2 edwinsu edwinsu 4.0K Apr 24 05:56 Variable_10u
#~ dr-xr-xr-x 2 edwinsu edwinsu 4.0K Apr 24 06:14 Variable_10v
#~ dr-xr-xr-x 2 edwinsu edwinsu  12K Apr 24 06:12 Variable_temp_2m
#~ dr-xr-xr-x 2 edwinsu edwinsu 4.0K Apr 24 06:20 Variable_tpre


# steps:
# - mergetime hourly u 
# - mergetime hourly v
# - cat hourly u and v 
# - calculate hourly wind speed
# - calculate daily value


# - mergetime hourly u
HOURLY_SOURCE_DIR_WIND_U=${MAIN_HOURLY_SOURCE_DIR}/Variable_10u
MERGE_OUTPUT_FILE_WIND_U=${OUTPUT_FOLDER}/tmp_era5-land_10u_${YEAR}.nc
cdo -L -b F64 -selyear,${YEAR} -shifttime,-25min -mergetime ${HOURLY_SOURCE_DIR}/*${YEAR}*.nc ${HOURLY_SOURCE_DIR}/*${YEAR_PLUS_1}01.nc ${MERGE_OUTPUT_FILE_WIND_U} &

# - mergetime hourly v
HOURLY_SOURCE_DIR_WIND_V=${MAIN_HOURLY_SOURCE_DIR}/Variable_10v
MERGE_OUTPUT_FILE_WIND_V=${OUTPUT_FOLDER}/tmp_era5-land_10v_${YEAR}.nc
cdo -L -b F64 -selyear,${YEAR} -shifttime,-25min -mergetime ${HOURLY_SOURCE_DIR}/*${YEAR}*.nc ${HOURLY_SOURCE_DIR}/*${YEAR_PLUS_1}01.nc ${MERGE_OUTPUT_FILE_WIND_V} &

wait


# cat hourly u and v
MERGE_OUTPUT_FILE_WIND_HOURLY=${OUTPUT_FOLDER}/tmp_era5-land_10u-10v_${YEAR}.nc
cdo -L -cat ${MERGE_OUTPUT_FILE_WIND_U} ${MERGE_OUTPUT_FILE_WIND_V} ${MERGE_OUTPUT_FILE_WIND_HOURLY}

 
# calculate hourly wind speed (with expression)
HOURLY_WIND_SPEED_OUTPUT_FILE=${OUTPUT_FOLDER}/tmp_era5-land_wind_speed_10m_${YEAR}.nc
cdo -L -expr 'wind_speed_10m = sqrt(u10*u10 + v10*v10)' ${MERGE_OUTPUT_FILE_WIND_HOURLY} ${HOURLY_WIND_SPEED_OUTPUT_FILE} 
ncview ${HOURLY_WIND_SPEED_OUTPUT_FILE}

# calculate daily values



#~ # daily tp, total precipitation
#~ HOURLY_SOURCE_DIR=${MAIN_HOURLY_SOURCE_DIR}/Variable_tpre
#~ # - daily total precipitation, NOTE: using daymax (as hourly source data are accumulative on each day)
#~ DAILY_OUTPUT_FILE=${OUTPUT_FOLDER}/tanzania_era5-land_daily_total-preci_${YEAR}.nc
#~ cdo -L -b F64 -settime,00:00:00 -setunit,m.day-1 -daymax -selyear,${YEAR} -shifttime,-25min -selvar,tp -mergetime ${HOURLY_SOURCE_DIR}/*${YEAR}*.nc ${HOURLY_SOURCE_DIR}/*${YEAR_PLUS_1}01.nc ${DAILY_OUTPUT_FILE} 
#~ 
#~ # monthly tp, total precipitation
#~ MONTHLY_UNIT="m.month-1"
#~ CDOMON_OPERA="monsum"
#~ MONTH_OUTPUT_FILE=${OUTPUT_FOLDER}/tanzania_era5-land_monthly_total-preci_${YEAR}.nc
#~ CDO_TIMESTAT_DATE='last' cdo -L -settime,00:00:00 -setunit,${MONTHLY_UNIT} -${CDOMON_OPERA} ${DAILY_OUTPUT_FILE} ${MONTH_OUTPUT_FILE} 
#~ 
#~ 
#~ # daily temp_2m
#~ HOURLY_SOURCE_DIR=${MAIN_HOURLY_SOURCE_DIR}/Variable_temp_2m
#~ # - using daymean
#~ DAILY_OUTPUT_FILE=${OUTPUT_FOLDER}/tanzania_era5-land_daily_t2m-average_${YEAR}.nc
#~ cdo -L -b F64 -settime,00:00:00 -setunit,m.day-1 -daymean -selyear,${YEAR} -shifttime,-25min -selvar,t2m -mergetime ${HOURLY_SOURCE_DIR}/*${YEAR}*.nc ${HOURLY_SOURCE_DIR}/*${YEAR_PLUS_1}01.nc ${DAILY_OUTPUT_FILE} 
#~ 
#~ # monthly temp_2m
#~ MONTHLY_UNIT="K"
#~ CDOMON_OPERA="monmean"
#~ MONTH_OUTPUT_FILE=${OUTPUT_FOLDER}/tanzania_era5-land_monthly_t2m-average_${YEAR}.nc
#~ CDO_TIMESTAT_DATE='last' cdo -L -settime,00:00:00 -setunit,${MONTHLY_UNIT} -${CDOMON_OPERA} ${DAILY_OUTPUT_FILE} ${MONTH_OUTPUT_FILE} 



#~ # ssr, surface solar radiation
#~ HOURLY_SOURCE_DIR=${MAIN_HOURLY_SOURCE_DIR}/Variable_Snsr
#~ # - daily total, NOTE: using daymax (as hourly source data are accumulative on each day)
#~ cdo -L -b F64 -settime,00:00:00 -setunit,J.m-2.day-1 -daymax -selyear,2000/2000 -shifttime,-25min -selvar,ssr -mergetime ${HOURLY_SOURCE_DIR}/*.nc ${OUTPUT_FOLDER}/tanzania_era5-land_daily_total-ssrad_2000-2000.nc &
#~ 
#~ # d2m
#~ HOURLY_SOURCE_DIR=${MAIN_HOURLY_SOURCE_DIR}/Variable_Temp
#~ # - maximum
#~ cdo -L -b F64 -settime,00:00:00 -setunit,K -daymax -selyear,2000/2000 -shifttime,-25min -selvar,d2m -mergetime ${HOURLY_SOURCE_DIR}/*.nc ${OUTPUT_FOLDER}/tanzania_era5-land_daily_d2m-maximum_2000-2000.nc &
#~ # - mean
#~ cdo -L -b F64 -settime,00:00:00 -setunit,K -daymean -selyear,2000/2000 -shifttime,-25min -selvar,d2m -mergetime ${HOURLY_SOURCE_DIR}/*.nc ${OUTPUT_FOLDER}/tanzania_era5-land_daily_d2m-average_2000-2000.nc &
#~ # - minimum
#~ cdo -L -b F64 -settime,00:00:00 -setunit,K -daymin -selyear,2000/2000 -shifttime,-25min -selvar,d2m -mergetime ${HOURLY_SOURCE_DIR}/*.nc ${OUTPUT_FOLDER}/tanzania_era5-land_daily_d2m-minimum_2000-2000.nc &
#~ 
#~ # t2m
#~ HOURLY_SOURCE_DIR=${MAIN_HOURLY_SOURCE_DIR}/Variable_Temp
#~ # - maximum
#~ cdo -L -b F64 -settime,00:00:00 -setunit,K -daymax -selyear,2000/2000 -shifttime,-25min -selvar,t2m -mergetime ${HOURLY_SOURCE_DIR}/*.nc ${OUTPUT_FOLDER}/tanzania_era5-land_daily_t2m-maximum_2000-2000.nc &
#~ # - mean
#~ cdo -L -b F64 -settime,00:00:00 -setunit,K -daymean -selyear,2000/2000 -shifttime,-25min -selvar,t2m -mergetime ${HOURLY_SOURCE_DIR}/*.nc ${OUTPUT_FOLDER}/tanzania_era5-land_daily_t2m-average_2000-2000.nc &
#~ # - minimum
#~ cdo -L -b F64 -settime,00:00:00 -setunit,K -daymin -selyear,2000/2000 -shifttime,-25min -selvar,t2m -mergetime ${HOURLY_SOURCE_DIR}/*.nc ${OUTPUT_FOLDER}/tanzania_era5-land_daily_t2m-minimum_2000-2000.nc &
#~ 
#~ # fal
#~ HOURLY_SOURCE_DIR=${MAIN_HOURLY_SOURCE_DIR}/Variable_Falb
#~ # - mean
#~ cdo -L -b F64 -settime,00:00:00 -setunit,dimensionless -daymean -selyear,2000/2000 -shifttime,-25min -selvar,fal -mergetime ${HOURLY_SOURCE_DIR}/*.nc ${OUTPUT_FOLDER}/tanzania_era5-land_daily_fal-average_2000-2000.nc &
#~ 
#~ # sp
#~ HOURLY_SOURCE_DIR=${MAIN_HOURLY_SOURCE_DIR}/Variable_Spre
#~ # - mean
#~ cdo -L -b F64 -settime,00:00:00 -setunit,Pa -daymean -selyear,2000/2000 -shifttime,-25min -selvar,sp -mergetime ${HOURLY_SOURCE_DIR}/*.nc ${OUTPUT_FOLDER}/tanzania_era5-land_daily_spressu-avg_2000-2000.nc &
#~ 
#~ # u10
#~ HOURLY_SOURCE_DIR=${MAIN_HOURLY_SOURCE_DIR}/Variable_Wind
#~ # - mean
#~ cdo -L -b F64 -settime,00:00:00 -setunit,m.s-1 -daymean -selyear,2000/2000 -shifttime,-25min -selvar,u10 -mergetime ${HOURLY_SOURCE_DIR}/*.nc ${OUTPUT_FOLDER}/tanzania_era5-land_daily_u10-average_2000-2000.nc &
#~ 
#~ # v10
#~ HOURLY_SOURCE_DIR=${MAIN_HOURLY_SOURCE_DIR}/Variable_Wind
#~ # - mean
#~ cdo -L -b F64 -settime,00:00:00 -setunit,m.s-1 -daymean -selyear,2000/2000 -shifttime,-25min -selvar,v10 -mergetime ${HOURLY_SOURCE_DIR}/*.nc ${OUTPUT_FOLDER}/tanzania_era5-land_daily_v10-average_2000-2000.nc &



set +x
