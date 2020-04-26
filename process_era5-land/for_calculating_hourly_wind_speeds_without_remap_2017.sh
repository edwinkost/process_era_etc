
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
HOURLY_SOURCE_DIR_WIND_U=${MAIN_HOURLY_SOURCE_DIR}/Variable_10u/
MERGE_OUTPUT_FILE_WIND_U=${OUTPUT_FOLDER}/tmp_era5-land_10u_${YEAR}.nc
cdo -L -b F64 -selyear,${YEAR} -shifttime,-25min -mergetime ${HOURLY_SOURCE_DIR_WIND_U}/*${YEAR}*.nc ${HOURLY_SOURCE_DIR_WIND_U}/*${YEAR_PLUS_1}01.nc ${MERGE_OUTPUT_FILE_WIND_U} &

#~ # - for testing with 2020 only
#~ cdo -L -b F64 -selyear,${YEAR} -shifttime,-25min -mergetime ${HOURLY_SOURCE_DIR_WIND_U}/*${YEAR}*.nc ${MERGE_OUTPUT_FILE_WIND_U} &

# - mergetime hourly v
HOURLY_SOURCE_DIR_WIND_V=${MAIN_HOURLY_SOURCE_DIR}/Variable_10v/
MERGE_OUTPUT_FILE_WIND_V=${OUTPUT_FOLDER}/tmp_era5-land_10v_${YEAR}.nc
cdo -L -b F64 -selyear,${YEAR} -shifttime,-25min -mergetime ${HOURLY_SOURCE_DIR_WIND_V}/*${YEAR}*.nc ${HOURLY_SOURCE_DIR_WIND_V}/*${YEAR_PLUS_1}01.nc ${MERGE_OUTPUT_FILE_WIND_V} &

#~ # - for testing with 2020
#~ cdo -L -b F64 -selyear,${YEAR} -shifttime,-25min -mergetime ${HOURLY_SOURCE_DIR_WIND_V}/*${YEAR}*.nc ${MERGE_OUTPUT_FILE_WIND_V} &

wait


# cat hourly u and v
MERGE_OUTPUT_FILE_WIND_HOURLY=${OUTPUT_FOLDER}/tmp_era5-land_10u-10v_${YEAR}.nc
cdo -L -merge ${MERGE_OUTPUT_FILE_WIND_U} ${MERGE_OUTPUT_FILE_WIND_V} ${MERGE_OUTPUT_FILE_WIND_HOURLY}

 
# calculate hourly wind speed (with expression)
HOURLY_WIND_SPEED_OUTPUT_FILE=${OUTPUT_FOLDER}/tmp_era5-land_wind_speed_10m_${YEAR}.nc
cdo -L -setunit,"m.s-1" -expr,'wind_speed_10m = sqrt(u10*u10 + v10*v10)' ${MERGE_OUTPUT_FILE_WIND_HOURLY} ${HOURLY_WIND_SPEED_OUTPUT_FILE} 
ncview ${HOURLY_WIND_SPEED_OUTPUT_FILE}


set +x
