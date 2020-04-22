
set -x

#~ # -year 2017, months 1 to 12
#~ python download_era5-land_global.py /scratch/depfg/sutan101/era5-land_meteo/hourly/ temp 2017 2017 1 12 0 &
#~ python download_era5-land_global.py /scratch/depfg/sutan101/era5-land_meteo/hourly/ wind 2017 2017 1 12 0 &
#~ python download_era5-land_global.py /scratch/depfg/sutan101/era5-land_meteo/hourly/ tp   2017 2017 1 12 0 &

# -year 2018, month 1 only
python download_era5-land_global.py /scratch/depfg/sutan101/era5-land_meteo/hourly/ temp 2018 2018 1  1 0 &
python download_era5-land_global.py /scratch/depfg/sutan101/era5-land_meteo/hourly/ wind 2018 2018 1  1 0 &
python download_era5-land_global.py /scratch/depfg/sutan101/era5-land_meteo/hourly/ tp   2018 2018 1  1 0 &

wait

set +x
