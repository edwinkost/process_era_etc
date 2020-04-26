
set -x

OUTPUT_FOLDER="/scratch-shared/edwinsu/era5-land_meteo/without_remapcon/wind_speed_10m/"
OUTPUT_FOLDER=${OUTPUT_FOLDER}/${YEAR}

HOURLY_SOURCE_FILE="/scratch/shared/edwinsu/era5-land_meteo/without_remapcon/wind_speed_10m/2017/hourly_tmp/tmp_era5-land_wind_speed_10m_2017.nc"

# daily 
DAILY_OUTPUT_FILE=${OUTPUT_FOLDER}/era5-land_daily_wind_speed_10m_2017.nc
cdo -L -b F64 -settime,00:00:00 -daymean ${HOURLY_SOURCE_FILE} ${DAILY_OUTPUT_FILE} 

# monthly
MONTH_OUTPUT_FILE=${OUTPUT_FOLDER}/era5-land_monthly_wind_speed_10m_2017.nc
CDO_TIMESTAT_DATE='last' cdo -L -settime,00:00:00 -monmean ${DAILY_OUTPUT_FILE} ${MONTH_OUTPUT_FILE} 

set +x
