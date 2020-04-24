
set -x

MAIN_HOURLY_SOURCE_DIR="/scratch-shared/edwinsu/era5-land_meteo/hourly/"

#~ edwinsu@tcn741.bullx:/scratch-shared/edwinsu/era5-land_meteo/hourly$ ls -lah  
#~ total 56K
#~ dr-xr-xr-x 6 edwinsu edwinsu 4.0K Apr 23 22:46 .
#~ drwxr-xr-x 3 edwinsu edwinsu 4.0K Apr 23 22:46 ..
#~ dr-xr-xr-x 2 edwinsu edwinsu 4.0K Apr 24 05:56 Variable_10u
#~ dr-xr-xr-x 2 edwinsu edwinsu 4.0K Apr 24 06:14 Variable_10v
#~ dr-xr-xr-x 2 edwinsu edwinsu  12K Apr 24 06:12 Variable_temp_2m
#~ dr-xr-xr-x 2 edwinsu edwinsu 4.0K Apr 24 06:20 Variable_tpre

YEAR=2017
YEAR_PLUS_1=2018

OUTPUT_FOLDER="/scratch-shared/edwinsu/era5-land_meteo/without_remapcon/"
OUTPUT_FOLDER=${OUTPUT_FOLDER}/${YEAR}
mkdir -p ${OUTPUT_FOLDER}

# daily tp, total precipitation
HOURLY_SOURCE_DIR=${MAIN_HOURLY_SOURCE_DIR}/Variable_tpre
# - daily total precipitation, NOTE: using daymax (as hourly source data are accumulative on each day)
DAILY_OUTPUT_FILE=${OUTPUT_FOLDER}/tanzania_era5-land_daily_total-preci_${YEAR}.nc
cdo -L -b F64 -settime,00:00:00 -setunit,m.day-1 -daymax -selyear,${YEAR}/${YEAR_PLUS_1} -shifttime,-25min -selvar,tp -mergetime ${HOURLY_SOURCE_DIR}/*${YEAR}*.nc ${HOURLY_SOURCE_DIR}/*${YEAR_PLUS_1}01.nc ${DAILY_OUTPUT_FILE} &

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

wait

set +x
