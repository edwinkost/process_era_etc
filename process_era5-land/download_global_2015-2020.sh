
set -x

# -year 2015, months 1 to 12
python download_era5-land_global.py /scratch/depfg/sutan101/era5-land_meteo/hourly/ temp_2m    2015 2015 1 12 0 &
python download_era5-land_global.py /scratch/depfg/sutan101/era5-land_meteo/hourly/ wind_10m_u 2015 2015 1 12 0 &
python download_era5-land_global.py /scratch/depfg/sutan101/era5-land_meteo/hourly/ wind_10m_v 2015 2015 1 12 0 &
python download_era5-land_global.py /scratch/depfg/sutan101/era5-land_meteo/hourly/ tp         2015 2015 1 12 0 &

# -year 2016, months 1 to 12
python download_era5-land_global.py /scratch/depfg/sutan101/era5-land_meteo/hourly/ temp_2m    2016 2016 1 12 0 &
python download_era5-land_global.py /scratch/depfg/sutan101/era5-land_meteo/hourly/ wind_10m_u 2016 2016 1 12 0 &
python download_era5-land_global.py /scratch/depfg/sutan101/era5-land_meteo/hourly/ wind_10m_v 2016 2016 1 12 0 &
python download_era5-land_global.py /scratch/depfg/sutan101/era5-land_meteo/hourly/ tp         2016 2016 1 12 0 &

# -year 2017, month 1 to 12
python download_era5-land_global.py /scratch/depfg/sutan101/era5-land_meteo/hourly/ temp_2m    2017 2017 1 12 0 &
python download_era5-land_global.py /scratch/depfg/sutan101/era5-land_meteo/hourly/ wind_10m_u 2017 2017 1 12 0 &
python download_era5-land_global.py /scratch/depfg/sutan101/era5-land_meteo/hourly/ wind_10m_v 2017 2017 1 12 0 &
python download_era5-land_global.py /scratch/depfg/sutan101/era5-land_meteo/hourly/ tp         2017 2017 1 12 0 &

# -year 2018, month 1 to 12
python download_era5-land_global.py /scratch/depfg/sutan101/era5-land_meteo/hourly/ temp_2m    2018 2018 1 12 0 &
python download_era5-land_global.py /scratch/depfg/sutan101/era5-land_meteo/hourly/ wind_10m_u 2018 2018 1 12 0 &
python download_era5-land_global.py /scratch/depfg/sutan101/era5-land_meteo/hourly/ wind_10m_v 2018 2018 1 12 0 &
python download_era5-land_global.py /scratch/depfg/sutan101/era5-land_meteo/hourly/ tp         2018 2018 1 12 0 &

# -year 2019, month 1 to 12
python download_era5-land_global.py /scratch/depfg/sutan101/era5-land_meteo/hourly/ temp_2m    2019 2019 1 12 0 &
python download_era5-land_global.py /scratch/depfg/sutan101/era5-land_meteo/hourly/ wind_10m_u 2019 2019 1 12 0 &
python download_era5-land_global.py /scratch/depfg/sutan101/era5-land_meteo/hourly/ wind_10m_v 2019 2019 1 12 0 &
python download_era5-land_global.py /scratch/depfg/sutan101/era5-land_meteo/hourly/ tp         2019 2019 1 12 0 &

# -year 2020, month 1 only
python download_era5-land_global.py /scratch/depfg/sutan101/era5-land_meteo/hourly/ temp_2m    2020 2020 1  1 0 &
python download_era5-land_global.py /scratch/depfg/sutan101/era5-land_meteo/hourly/ wind_10m_u 2020 2020 1  1 0 &
python download_era5-land_global.py /scratch/depfg/sutan101/era5-land_meteo/hourly/ wind_10m_v 2020 2020 1  1 0 &
python download_era5-land_global.py /scratch/depfg/sutan101/era5-land_meteo/hourly/ tp         2020 2020 1  1 0 &

wait

set +x
