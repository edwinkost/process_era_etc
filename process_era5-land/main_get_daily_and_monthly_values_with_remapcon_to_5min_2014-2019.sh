
set -x

bash get_daily_and_monthly_values_with_remapcon_to_5min.sh 2014 2015 &
bash get_daily_and_monthly_values_with_remapcon_to_5min.sh 2015 2016 &
bash get_daily_and_monthly_values_with_remapcon_to_5min.sh 2016 2017 &
bash get_daily_and_monthly_values_with_remapcon_to_5min.sh 2017 2018 &
bash get_daily_and_monthly_values_with_remapcon_to_5min.sh 2018 2019 &
bash get_daily_and_monthly_values_with_remapcon_to_5min.sh 2019 2020 &

wait

set +x
